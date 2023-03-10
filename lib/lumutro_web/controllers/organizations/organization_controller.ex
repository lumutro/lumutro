defmodule LumutroWeb.Organizations.OrganizationController do
  use LumutroWeb, :controller

  alias Lumutro.Organizations
  alias Lumutro.Users
  alias Lumutro.Organizations.Organization

  def index(conn, _params) do
    %{organizations: organizations} = Users.with_memberships(conn.assigns.current_user)
    render(conn, :index, organizations: organizations)
  end

  def new(conn, _params) do
    changeset = Organizations.change_organization(%Organization{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"organization" => organization_params}) do
    user = conn.assigns.current_user

    with {:ok, organization} <- Organizations.create_organization(organization_params),
         {:ok, _} <- Organizations.create_membership(organization, user, %{role: :owner}) do
      conn
      |> put_flash(:info, "Organization created successfully.")
      |> redirect(to: ~p"/orgs/#{organization}")
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Organizations.get_organization!(id)
    render(conn, :show, organization: organization)
  end

  def edit(conn, %{"id" => id}) do
    organization = Organizations.get_organization!(id)
    changeset = Organizations.change_organization(organization)
    render(conn, :edit, organization: organization, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Organizations.get_organization!(id)

    case Organizations.update_organization(organization, organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: ~p"/orgs/#{organization}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Organizations.get_organization!(id)
    {:ok, _organization} = Organizations.delete_organization(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: ~p"/orgs")
  end
end
