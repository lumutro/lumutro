defmodule Lumutro.OrganizationsTest do
  use Lumutro.DataCase

  import Lumutro.OrganizationsFixtures
  import Lumutro.UsersFixtures

  alias Lumutro.Organizations
  alias Lumutro.Organizations.Membership

  defp setup_user(_) do
    user = user_fixture()
    {:ok, user: user}
  end

  defp setup_organization(_) do
    organization = organization_fixture()
    {:ok, organization: organization}
  end

  describe "organizations" do
    alias Lumutro.Organizations.Organization

    import Lumutro.OrganizationsFixtures

    @invalid_attrs %{name: nil}

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Organization{} = organization} =
               Organizations.create_organization(valid_attrs)

      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Organization{} = organization} =
               Organizations.update_organization(organization, update_attrs)

      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Organizations.update_organization(organization, @invalid_attrs)

      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end

  describe "memberships" do
    setup [:setup_user, :setup_organization]

    test "create_membership/1 with valid data creates a membership", %{
      user: user,
      organization: organization
    } do
      valid_attrs = %{}

      assert {:ok, %Membership{} = _membership} =
               Organizations.create_membership(organization, user, valid_attrs)
    end
  end
end
