defmodule VersionObserverWeb.PageController do
  use VersionObserverWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
