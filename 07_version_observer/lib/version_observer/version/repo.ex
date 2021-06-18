defmodule VersionObserver.Version.Repo do
  use GenServer

  require Logger

  alias VersionObserver.Version

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)

    GenServer.start_link(__MODULE__, %{}, name: name)
  end

  def get(name \\ __MODULE__), do: GenServer.call(name, :get)

  @impl true
  def init(_) do
    log("starting")

    {:ok, version} =
      :version_observer
      |> Application.spec(:vsn)
      |> to_string()
      |> Version.from_string()

    {:ok, version}
  end

  @impl GenServer
  def handle_call(:get, _, version) do
    log("returning version #{inspect(version)}")

    {:reply, {:ok, version}, version}
  end

  defp(log(text)) do
    Logger.info("----[#{node()}-#{inspect(self())}] #{__MODULE__} #{text}")
  end
end
