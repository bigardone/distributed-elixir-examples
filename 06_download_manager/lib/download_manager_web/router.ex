defmodule DownloadManagerWeb.Router do
  use DownloadManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DownloadManagerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DownloadManagerWeb.AuthPlug
  end

  scope "/", DownloadManagerWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end
end
