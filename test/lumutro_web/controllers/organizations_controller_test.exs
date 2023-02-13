defmodule LumutroWeb.OrganizationsControllerTest do
  use LumutroWeb.ConnCase, async: true

  setup :register_and_log_in_user

  @create_attrs %{name: "Test Organization"}

  describe "POST /orgs" do
    test "creates an organization", %{conn: conn} do
      conn = post(conn, ~p"/orgs", organization: @create_attrs)

      assert %{id: _id} = redirected_params(conn)
    end
  end
end
