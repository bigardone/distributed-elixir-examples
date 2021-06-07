defmodule DownloadManager do
  defdelegate start_download(user_id), to: DownloadManager.Download.Tracker, as: :start
  defdelegate fetch_download(user_id), to: DownloadManager.Download.Repo, as: :fetch
  defdelegate delete_download(download), to: DownloadManager.Download.Repo, as: :remove
end
