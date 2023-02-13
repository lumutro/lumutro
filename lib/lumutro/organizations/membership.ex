defmodule Lumutro.Organizations.Membership do
  @moduledoc """
  The membership schema. A member is the relationship between users and organizations
  and tells which organizations a user have access to
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_memberships" do
    field :role, Ecto.Enum, values: [:owner, :member], default: :member

    belongs_to :user, Lumutro.Users.User, foreign_key: :user_id
    belongs_to :organization, Lumutro.Organizations.Organization, foreign_key: :organization_id

    timestamps()
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> unique_constraint(:user, name: :organization_memberships_organization_id_user_id_index)
  end
end
