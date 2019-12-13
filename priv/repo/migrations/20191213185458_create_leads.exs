defmodule Martify.Repo.Migrations.CreateLeads do
  use Ecto.Migration

  def change do
    create table(:leads) do
      add :name, :string
      add :phone, :string
      add :email, :string

      timestamps()
    end

  end
end
