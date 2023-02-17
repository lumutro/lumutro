defmodule LumutroWeb.PageControllerTest do
  use LumutroWeb.ConnCase

  describe "GET /" do
    test "redirect to login if not logged in", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert redirected_to(conn) == ~p"/users/log_in"
    end

    test "redirects to /orgs if logged in", %{conn: conn} do
      %{conn: conn, user: _} = register_and_log_in_user(%{conn: conn})
      conn = get(conn, ~p"/")

      assert redirected_to(conn) == ~p"/orgs"
    end
  end
end
