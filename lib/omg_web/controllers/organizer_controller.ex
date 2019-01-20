defmodule OmgWeb.OrganizerController do

  require Logger
  use OmgWeb, :controller

  def create(conn, _params) do

    Logger.info "Received JSON: #{inspect(conn.body_params)}"
    json(conn, conn.body_params)

  end
end
