defmodule VersionObserverWeb.VersionChannel do
  use VersionObserverWeb, :channel

  alias Phoenix.PubSub

  @impl Phoenix.Channel
  def join("version", _payload, socket) do
    PubSub.subscribe(VersionObserver.PubSub, "version_monitor")

    {:ok, socket}
  end

  @impl Phoenix.Channel
  def handle_info({:new_version, version}, socket) do
    push(socket, "new_version", %{version: version})

    {:noreply, socket}
  end
end
