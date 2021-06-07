defmodule DownloadManager.Download.Repo.Nebulex do
  use Nebulex.Cache,
    otp_app: :download_manager,
    adapter: Nebulex.Adapters.Replicated

  alias DownloadManager.{Download, Download.Repo}

  @behaviour Repo

  @impl Repo
  def start(opts) do
    start_link(opts)
  end

  @impl Repo
  def fetch(user_id) do
    case get(user_id) do
      nil ->
        {:error, :not_found}

      download ->
        {:ok, download}
    end
  end

  @impl Repo
  def insert(%Download{user_id: user_id} = download) do
    if put_new(user_id, download) do
      {:ok, download}
    else
      {:error, :unexpected_error}
    end
  end

  @impl Repo
  def update(%Download{user_id: user_id} = download) do
    :ok = put(user_id, download, ttl: :timer.seconds(5))

    {:ok, download}
  end

  @impl Repo
  def remove(%Download{user_id: user_id} = download) do
    :ok = delete(user_id)

    {:ok, download}
  end
end
