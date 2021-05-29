defmodule GlobalBackgroundJob.Singleton do
  @moduledoc """
  GenServer which starts and monitors another process, restarting
  it when it goes down.
  """

  use GenServer
  require Logger

  alias __MODULE__.State

  def start_link(opts) do
    mod = Keyword.fetch!(opts, :mod)
    args = Keyword.fetch!(opts, :args)
    name = Keyword.fetch!(opts, :name)

    GenServer.start_link(__MODULE__, %{mod: mod, args: args, name: name})
  end

  @impl GenServer
  def init(opts) do
    log("starting")

    state =
      opts
      |> State.build()
      |> start_and_monitor()

    {:ok, state}
  end

  @impl GenServer
  def handle_info({:DOWN, _, :process, pid, _reason}, state = %State{pid: pid}) do
    log("process down, restarting... #{inspect(state)}")

    {:noreply, start_and_monitor(state)}
  end

  defp start_and_monitor(%State{mod: mod, args: args, name: name} = state) do
    log("restarting #{inspect(state)}...")

    pid = start_child(mod, args, name)

    Process.monitor(pid)

    state = State.with_pid(state, pid)

    log("monitoring #{inspect(state)}...")

    state
  end

  defp start_child(mod, args, name) do
    case GenServer.start_link(mod, args, name: {:global, name}) do
      {:ok, pid} ->
        pid

      {:error, {:already_started, pid}} ->
        log("...already started!")
        pid
    end
  end

  defp log(text) do
    Logger.info("----[#{node()}] #{__MODULE__} #{text}")
  end
end
