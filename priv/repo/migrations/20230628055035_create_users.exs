defmodule Boundary.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:active, :boolean, default: false, null: false)
      add(:paid_at, :utc_datetime, null: true)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
