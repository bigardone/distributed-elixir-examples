defmodule SwarmBackgroundJob.DatabaseCleaner.Starter do
  use GenServer
  require Logger

  alias SwarmBackgroundJob.DatabaseCleaner
  alias SwarmBackgroundJob.DatabaseCleaner.Supervisor, as: DatabaseCleanerSupervisor

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(opts) do
    {:ok, opts, {:continue, {:start_and_monitor, 1}}}
  end

  @impl GenServer
  def handle_continue({:start_and_monitor, retry}, opts) do
    log("starting and monitoring #{retry}: #{inspect(opts)}...")

    case Swarm.whereis_or_register_name(
           DatabaseCleaner,
           DatabaseCleanerSupervisor,
           :start_child,
           [opts]
         ) do
      {:ok, pid} ->
        Process.monitor(pid)

        {:noreply, {pid, opts}}

      other ->
        log("error while fetching or registering process: #{inspect(other)}")

        Process.sleep(500)
        {:noreply, opts, {:continue, {:start_and_monitor, retry + 1}}}
    end
  end

  @impl GenServer
  def handle_info({:DOWN, _, :process, pid, _reason}, {pid, opts}) do
    log("process down, restarting... #{inspect(opts)}")

    {:noreply, opts, {:continue, {:start_and_monitor, 1}}}
  end

  defp log(text) do
    Logger.info("----[#{node()}] #{__MODULE__} #{text}")
  end
end
