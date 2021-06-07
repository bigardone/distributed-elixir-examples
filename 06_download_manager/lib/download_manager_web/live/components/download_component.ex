defmodule DownloadManagerWeb.DownloadLiveComponent do
  use Phoenix.LiveComponent

  alias DownloadManager.Download

  @pending_state Download.pending_state()
  @processing_state Download.processing_state()
  @ready_state Download.ready_state()

  def render(%{download: %Download{state: state}} = assigns) do
    ~L"""
    <div>
      <div class="bg-white p-5 rounded shadow-md absolute top-0 right-0 w-80 mt-6 mr-6 border-gray-100 border text-sm leading-7 flex gap-x-4">
        <%= icon(state) %>
        <div>
          <h4 class="font-bold">Generating downloadable file</h4>
          <p class="text-gray-500"><%= state_text(state) %></p>
          <%= if Download.ready?(@download) do %>
            <a phx-click="delete_download" class="text-purple-800 cursor-pointer hover:underline" hrerf="<%= @download.file_url %>">Click me to download the file</a>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  defp state_text(@pending_state), do: "Starting download request"
  defp state_text(@processing_state), do: "Generating file..."
  defp state_text(@ready_state), do: "File generated with success"

  defp icon(@ready_state) do
    Phoenix.HTML.raw("""
    <div class="text-green-500 mt-2 relative w-4 h-4">
      <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
      <svg class="absolute" height="16px" width="16px" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="spinner" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
        <path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class=""></path>
      </svg>
    </div>
    """)
  end

  defp icon(_) do
    Phoenix.HTML.raw("""
    <div class="text-gray-300 mt-2">
      <svg height="16px" width="16px" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="spinner" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="animate-spin">
        <path fill="currentColor" d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z" class=""></path>
      </svg>
    </div>
    """)
  end
end
