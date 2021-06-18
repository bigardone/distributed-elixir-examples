defmodule VersionObserverWeb.LayoutView do
  use VersionObserverWeb, :view

  def get_current_version do
    {:ok, version} = VersionObserver.get_current_version()

    to_string(version)
  end
end
