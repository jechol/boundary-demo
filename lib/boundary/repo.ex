defmodule Boundary.Repo do
  use Ecto.Repo,
    otp_app: :boundary,
    adapter: Ecto.Adapters.Postgres
end
