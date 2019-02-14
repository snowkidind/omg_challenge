defmodule OmgWeb.OrganizerController do

  use OmgWeb, :controller

  def show(conn, _params) do
    response = Transcribe.start(conn.body_params)
    json(conn, response)
  end
end
