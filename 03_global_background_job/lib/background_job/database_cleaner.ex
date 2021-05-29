defmodule GlobalBackgroundJob.DatabaseCleaner do
  @moduledoc """
  Fake module that emulates deleting records randomly.
  """

  use GenServer
  require Logger

  alias __MODULE__.Runner

  @default_timeout :timer.seconds(2)

  @impl GenServer
  def init(args \\ []) do
    timeout = Keyword.get(args, :timeout, @default_timeout)

    schedule(timeout)

    {:ok, timeout}
  end

  @impl GenServer
  def handle_info(:execute, timeout) do
    log("deleting outdated records...")

    Task.start(Runner, :execute, [])

    schedule(timeout)

    {:noreply, timeout}
  end

  defp schedule(timeout) do
    log("scheduling for #{timeout}ms...")

    Process.send_after(self(), :execute, timeout)
  end

  defp log(text) do
    Logger.info("----[#{node()}] #{__MODULE__} #{text}")
  end
end
