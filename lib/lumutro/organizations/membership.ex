defmodule Lumutro.Organizations.Membership do
  @moduledoc """
  The membership schema. A member is the relationship between users and organizations
  and tells which organizations a user have access to
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "organization_memberships" do
    field :role, Ecto.Enum, values: [:owner, :member], default: :member

    belongs_to :member, Lumutro.Organizations.Member, foreign_key: :user_id
    belongs_to :organization, Lumutro.Organizations.Organization

    timestamps()
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> unique_constraint(:member, name: :organization_memberships_organization_id_user_id_index)
  end
end
