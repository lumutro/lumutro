defmodule Lumutro.Organizations.Member do
  @moduledoc """
  The memebr schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string

    has_many :memberships, Lumutro.Organizations.Membership, foreign_key: :user_id
    has_many :organizations, through: [:memberships, :organization]
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end
end
