defmodule OmgWeb.Router do
  use OmgWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", OmgWeb do
    pipe_through :browser
    get "/", GithubSearchController, :index # default page
    post "/", GithubSearchController, :index # search request
  end

  scope "/github", OmgWeb do
    pipe_through :browser
    get "/", GithubSearchController, :index # navigation
  end

  # api post
  scope "/organize", OmgWeb do
    post "/", OrganizerController, :show # calculate JSON
  end

end
