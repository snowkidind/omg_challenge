defmodule OmgWeb.OrganizerController do

  require Logger
  use OmgWeb, :controller

  def create(conn, _params) do
    response = Transcribe.start(conn.body_params)
    json(conn, response)
  end
end
