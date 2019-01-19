defmodule OmgWeb.JsonController do
  use OmgWeb, :controller

  def index(conn, _params) do
    render(conn, "json.html")
  end
end
