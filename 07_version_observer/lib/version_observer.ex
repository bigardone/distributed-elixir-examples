defmodule VersionObserver do
  defdelegate get_current_version, to: VersionObserver.Version.Repo, as: :get
end
