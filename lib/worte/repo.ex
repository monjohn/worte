defmodule Worte.Repo do
  use Ecto.Repo,
    otp_app: :worte,
    adapter: Ecto.Adapters.Postgres
end
