defmodule DownloadManager.Download.Repo do
  @moduledoc """
  Download repository behaviour.
  """

  alias DownloadManager.Download

  @adapter Application.compile_env(:download_manager, __MODULE__)[:adapter]

  @type user_id :: String.t()
  @type result :: {:ok, Download.t()} | {:error, term}

  @callback start(keyword) :: GenServer.on_start()
  @callback fetch(user_id()) :: result
  @callback insert(Download.t()) :: result
  @callback update(Download.t()) :: result
  @callback remove(Download.t()) :: result

  defdelegate start_link(opts), to: @adapter
  defdelegate fetch(user_id), to: @adapter
  defdelegate insert(download), to: @adapter
  defdelegate update(download), to: @adapter
  defdelegate remove(download), to: @adapter

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end
end
