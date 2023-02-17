defmodule LumutroWeb.Utils.Pipes do
  use LumutroWeb, :verified_routes

  import Phoenix.Controller
  import Plug.Conn

  @doc """
  Redirects user on first organization in his memberships or /org if he has no memberships
  """
  def redirect_on_org(conn, _opts) do
    conn
    |> redirect(to: "/orgs")
    |> halt()
  end
end
