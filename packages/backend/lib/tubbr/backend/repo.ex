defmodule Tubbr.Repo do
  use Ecto.Repo,
    otp_app: :tubbr,
    adapter: Ecto.Adapters.Postgres
end
