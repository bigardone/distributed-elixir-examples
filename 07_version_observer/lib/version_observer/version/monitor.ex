defmodule VersionObserver.Version.Monitor do
  use GenServer
  require Logger

  alias __MODULE__.Runner
  alias Phoenix.PubSub
  alias VersionObserver.{NodeObserver, Version}

  @publish_topic "version_monitor"

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    subscribe_topic = Keyword.get(opts, :subscribe_topic, NodeObserver.topic())

    GenServer.start_link(__MODULE__, subscribe_topic, name: name)
  end

  @impl GenServer
  def init(subscribe_topic) do
    log("starting...")
    PubSub.subscribe(VersionObserver.PubSub, subscribe_topic)

    {:ok, %Version{}}
  end

  @impl GenServer
  def handle_continue(:check, state) do
    log("checking version")

    with {:ok, new_version} <- Runner.run(),
         true <- Version.incompatible?(new_version, state) do
      log("new incompatible version, broadcasting message...")

      Process.sleep(1_000)

      PubSub.broadcast(
        VersionObserver.PubSub,
        @publish_topic,
        {:new_version, to_string(new_version)}
      )

      {:noreply, new_version}
    else
      false ->
        log("compatible versions, ignoring.")

        {:noreply, state}

      {:error, :invalid_nodes} ->
        log("invalid nodes, checking again in a sec...")

        Process.sleep(1_000)

        {:noreply, state, {:continue, :check}}

      {:error, :out_of_sync} ->
        log("nodes out of sync, ignoring.")

        {:noreply, state}
    end
  end

  @impl GenServer
  def handle_info(:nodeup, state) do
    log(":nodeup message received...")

    {:noreply, state, {:continue, :check}}
  end

  def handle_info(:nodedown, state) do
    log(":nodedown message received...")

    {:noreply, state, {:continue, :check}}
  end

  defp log(text) do
    Logger.info("----[#{node()}-#{inspect(self())}] #{__MODULE__} #{text}")
  end
end
