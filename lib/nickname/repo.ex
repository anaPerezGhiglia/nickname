defmodule Nickname.Repo do
  use Ecto.Repo,
    otp_app: :nickname,
    adapter: Ecto.Adapters.Postgres
end
