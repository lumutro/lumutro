defmodule LumutroWeb.OrganizationsControllerTest do
  use LumutroWeb.ConnCase, async: true

  alias Lumutro.Organizations
  import Lumutro.OrganizationsFixtures

  setup :register_and_log_in_user

  @create_attrs %{name: "Test Organization"}

  describe "GET /orgs" do
    test "shows list of users organizations", %{conn: conn, user: user} do
      org1 = organization_fixture(%{name: "Google"})
      org2 = organization_fixture(%{name: "Amazon"})
      org3 = organization_fixture(%{name: "Facebook"})

      Organizations.create_membership(org1, user)
      Organizations.create_membership(org2, user)

      conn = get(conn, ~p"/orgs")
      response = html_response(conn, 200)

      assert response =~ "Google"
      assert response =~ "Amazon"
      refute response =~ "Facebook"
    end
  end

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
