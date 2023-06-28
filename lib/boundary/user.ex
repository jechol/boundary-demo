defmodule Boundary.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :active, :boolean, default: false
    field :email, :string
    field :paid_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :active, :paid_at])
    |> validate_required([:email, :active, :paid_at])
  end
end
