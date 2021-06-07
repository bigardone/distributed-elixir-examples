defmodule DownloadManager.Download.Tracker.Worker do
  @moduledoc """
  Download tracker worker behaviour
  """

  @adapter Application.compile_env(:download_manager, __MODULE__)[:adapter]

  @callback start_link(keyword) :: GenServer.on_start()

  defdelegate start_link(opts), to: @adapter
end
