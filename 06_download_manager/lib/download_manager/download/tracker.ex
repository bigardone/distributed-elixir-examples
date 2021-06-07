defmodule DownloadManager.Download.Tracker do
  @moduledoc """
  """

  alias __MODULE__.Worker
  alias DownloadManager.{Download, Download.Repo, HordeRegistry, HordeSupervisor}

  @spec start(String.t()) :: {:ok, Download.t()} | {:error, term}
  def start(user_id) do
    with download <- Download.new(user_id: user_id),
         {:ok, download} <- Repo.insert(download),
         child_spec <- worker_spec(download),
         {:ok, _} <- HordeSupervisor.start_child(child_spec) do
      {:ok, download}
    end
  end

  defp worker_spec(%Download{user_id: user_id} = download) do
    %{
      id: {Worker, user_id},
      start: {Worker, :start_link, [[download: download, name: via_tuple(user_id)]]},
      type: :worker,
      restart: :transient
    }
  end

  defp via_tuple(id) do
    {:via, Horde.Registry, {HordeRegistry, {Download, id}}}
  end
end
