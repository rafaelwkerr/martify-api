defmodule Martify.Repo do
  use Ecto.Repo,
    otp_app: :martify,
    adapter: Ecto.Adapters.Postgres
end
