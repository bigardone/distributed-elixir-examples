defmodule DownloadManager.Download.Tracker.Worker.Fake do
  @moduledoc """
  Fake module that emulates the generation of a download.
  """

  use GenServer
  require Logger

  alias DownloadManager.{Download, Download.Repo}
  alias Phoenix.PubSub

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    download = Keyword.fetch!(opts, :download)

    GenServer.start_link(__MODULE__, download, name: name)
  end

  @impl GenServer
  def init(download) do
    schedule(:start, 1_000)

    {:ok, download}
  end

  @impl GenServer
  def handle_info(:start, download) do
    log("starting download: #{inspect(download)}")

    {:ok, new_download} =
      download
      |> Download.with_pending_state()
      |> Repo.update()

    broadcast(new_download)
    schedule(:process, 1_000)

    {:noreply, new_download}
  end

  def handle_info(:process, download) do
    log("processing download: #{inspect(download)}")

    {:ok, new_download} =
      download
      |> Download.with_processing_state()
      |> Repo.update()

    broadcast(new_download)
    schedule(:ready, 5_000)

    {:noreply, new_download}
  end

  def handle_info(:ready, %Download{id: id} = download) do
    {:ok, new_download} =
      download
      |> Download.with_ready_state()
      |> Download.with_file_url("/downloads/#{id}.pdf")
      |> Repo.update()

    broadcast(new_download)

    log("download ready: #{inspect(new_download)}")

    {:stop, :normal, new_download}
  end

  defp schedule(action, timeout) do
    Process.send_after(self(), action, timeout)
  end

  defp broadcast(%Download{user_id: user_id} = download) do
    PubSub.broadcast(DownloadManager.PubSub, "download:#{user_id}", {:update, download})
  end

  defp log(text) do
    Logger.info("----[#{node()}-#{inspect(self())}] #{__MODULE__} #{text}")
  end
end
