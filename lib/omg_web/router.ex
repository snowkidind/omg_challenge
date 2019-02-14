defmodule OmgWeb.Router do
  use OmgWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    # plug :accepts, ["json"]
    # plug :accepts, ["json-api"]
    # plug Plug.Parsers, parsers: [:urlencoded]
    #plug JaSerializer.Deserializer

  end

  scope "/", OmgWeb do
    pipe_through :browser
    get "/", PageController, :index
    post "/", PageController, :index
  end

  scope "/github", OmgWeb do
    pipe_through :browser
    get "/", PageController, :index

  end

  scope "/organize", OmgWeb do
    #pipe_through :api
    resources "/", OrganizerController, only: [:create]
  end

end
