defmodule VersionObserver.NodeObserver do
  use GenServer

  alias Phoenix.PubSub
  alias VersionObserver.{HordeRegistry, HordeSupervisor}

  @topic "node_observer"

  def start_link(_), do: GenServer.start_link(__MODULE__, [])

  def topic, do: @topic

  @impl GenServer
  def init(_) do
    :net_kernel.monitor_nodes(true, node_type: :visible)

    {:ok, nil}
  end

  @impl GenServer
  def handle_info({:nodeup, _node, _node_type}, state) do
    set_members(HordeRegistry)
    set_members(HordeSupervisor)

    PubSub.broadcast(VersionObserver.PubSub, @topic, :nodeup)

    {:noreply, state}
  end

  def handle_info({:nodedown, _node, _node_type}, state) do
    set_members(HordeRegistry)
    set_members(HordeSupervisor)

    PubSub.broadcast(VersionObserver.PubSub, @topic, :nodedown)

    {:noreply, state}
  end

  defp set_members(name) do
    members = Enum.map([Node.self() | Node.list()], &{name, &1})

    :ok = Horde.Cluster.set_members(name, members)
  end
end
