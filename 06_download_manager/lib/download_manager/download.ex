defmodule DownloadManager.Download do
  alias __MODULE__
  alias DownloadManager.Token

  @pending_state :pending
  @processing_state :processing
  @error_state :error
  @ready_state :ready

  @type state :: :pending | :processing | :error | :ready

  @type t :: %Download{
          file_url: String.t() | nil,
          id: String.t(),
          state: state,
          user_id: String.t()
        }

  @enforce_keys [:id, :state, :user_id]

  defstruct [
    :file_url,
    :id,
    :state,
    :user_id
  ]

  def new(params) do
    with {:ok, user_id} <- Keyword.fetch(params, :user_id) do
      %Download{
        id: Token.generate(),
        state: @pending_state,
        user_id: user_id
      }
    end
  end

  def pending_state, do: @pending_state
  def processing_state, do: @processing_state
  def error_state, do: @error_state
  def ready_state, do: @ready_state

  def with_pending_state(%Download{} = download) do
    %{download | state: @pending_state}
  end

  def with_processing_state(%Download{} = download) do
    %{download | state: @processing_state}
  end

  def with_ready_state(%Download{} = download) do
    %{download | state: @ready_state}
  end

  def with_file_url(%Download{} = download, file_url) do
    %{download | file_url: file_url}
  end

  def ready?(%Download{state: state}), do: state == @ready_state
end
