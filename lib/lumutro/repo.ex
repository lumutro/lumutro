defmodule Lumutro.Repo do
  use Ecto.Repo,
    otp_app: :lumutro,
    adapter: Ecto.Adapters.Postgres
end
