defmodule GlobalBackgroundJob.DatabaseCleaner.Starter do
  @moduledoc """
  GenServer which starts and monitors another process, restarting
  it when it goes down.
  """

  use GenServer
  require Logger

  alias GlobalBackgroundJob.DatabaseCleaner

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(opts) do
    pid = start_and_monitor(opts)

    {:ok, {pid, opts}}
  end

  @impl GenServer
  def handle_info({:DOWN, _, :process, pid, _reason}, {pid, opts} = state) do
    log("process down, restarting... #{inspect(state)}")

    {:noreply, {start_and_monitor(opts), opts}}
  end

  defp start_and_monitor(opts) do
    log("restarting #{inspect(opts)}...")

    pid =
      case GenServer.start_link(DatabaseCleaner, opts, name: {:global, DatabaseCleaner}) do
        {:ok, pid} ->
          pid

        {:error, {:already_started, pid}} ->
          log("...already started!")
          pid
      end

    Process.monitor(pid)

    log("monitoring #{inspect(pid)}...")

    pid
  end

  defp log(text) do
    Logger.info("----[#{node()}] #{__MODULE__} #{text}")
  end
end
