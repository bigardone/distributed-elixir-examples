defmodule SwarmBackgroundJob.DatabaseCleaner do
  @moduledoc """
  Fake module that emulates deleting records randomly.
  """

  use GenServer
  require Logger

  alias __MODULE__.Runner

  @default_timeout :timer.seconds(2)

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    GenServer.start_link(__MODULE__, timeout, name: name)
  end

  @impl GenServer
  def init(timeout) do
    schedule(timeout)

    {:ok, timeout}
  end

  @impl GenServer
  def handle_call({:swarm, :begin_handoff}, _from, state) do
    log("beginning handoff with state #{inspect(state)}")

    {:reply, :restart, state}
  end

  @impl GenServer
  def handle_cast({:swarm, :resolve_conflict, _}, state) do
    log("resolving conflict with state #{inspect(state)}")

    {:noreply, state}
  end

  @impl GenServer
  def handle_info({:swarm, :die}, state) do
    {:stop, :shutdown, state}
  end

  def handle_info(:execute, timeout) do
    log("deleting outdated records...")

    Task.start(Runner, :execute, [])

    schedule(timeout)

    {:noreply, timeout}
  end

  defp schedule(timeout) do
    log("scheduling for #{timeout}ms")

    Process.send_after(self(), :execute, timeout)
  end

  defp log(text) do
    Logger.info("----[#{node()}] #{__MODULE__} #{text}")
  end
end
