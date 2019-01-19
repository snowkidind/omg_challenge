defmodule Omg.Repo do
  use Ecto.Repo,
    otp_app: :omg,
    adapter: Ecto.Adapters.Postgres
end
