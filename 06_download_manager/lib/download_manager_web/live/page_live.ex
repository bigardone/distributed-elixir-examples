defmodule DownloadManagerWeb.PageLive do
  use DownloadManagerWeb, :live_view

  alias Phoenix.PubSub

  @impl Phoenix.LiveView
  def mount(_params, %{"user_id" => user_id}, socket) do
    PubSub.subscribe(DownloadManager.PubSub, "download:#{user_id}")

    download =
      case DownloadManager.fetch_download(user_id) do
        {:ok, download} ->
          download

        {:error, :not_found} ->
          nil
      end

    {:ok, assign(socket, user_id: user_id, download: download)}
  end

  @impl Phoenix.LiveView
  def handle_event("request_download", _, socket) do
    case DownloadManager.start_download(socket.assigns.user_id) do
      {:ok, download} ->
        {:noreply, assign(socket, download: download)}

      _ ->
        {:noreply, put_flash(socket, :error, "Error creating download request")}
    end
  end

  def handle_event("delete_download", _, socket) do
    download = socket.assigns.download

    DownloadManager.delete_download(download)

    {:noreply, assign(socket, download: nil)}
  end

  @impl Phoenix.LiveView
  def handle_info({:update, download}, socket) do
    {:noreply, assign(socket, download: download)}
  end
end
