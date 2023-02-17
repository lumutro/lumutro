defmodule LumutroWeb.OrganizationsControllerTest do
  use LumutroWeb.ConnCase, async: true

  alias Lumutro.Organizations

  setup :register_and_log_in_user

  @create_attrs %{name: "Test Organization"}

  describe "POST /orgs" do
    test "creates an organization", %{conn: conn, user: user} do
      conn = post(conn, ~p"/orgs", organization: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert %{name: "Test Organization"} = organization = Organizations.get_organization!(id)
      assert %{members: members} = Organizations.with_members(organization)
      assert hd(members).id == user.id
    end
  end
end
