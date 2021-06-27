defmodule VersionObserver.Version.Monitor.Starter do
  require Logger

  alias VersionObserver.{
    HordeRegistry,
    HordeSupervisor,
    Version.Monitor
  }

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :temporary,
      shutdown: 500
    }
  end

  def start_link(opts) do
    name =
      opts
      |> Keyword.get(:name, Monitor)
      |> via_tuple()

    opts = Keyword.put(opts, :name, name)

    child_spec = %{
      id: Monitor,
      start: {Monitor, :start_link, [opts]}
    }

    HordeSupervisor.start_child(child_spec)

    :ignore
  end

  def whereis(name \\ Monitor) do
    name
    |> via_tuple()
    |> GenServer.whereis()
  end

  defp via_tuple(name) do
    {:via, Horde.Registry, {HordeRegistry, name}}
  end
end
