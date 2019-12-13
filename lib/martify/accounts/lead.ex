defmodule Martify.Accounts.Lead do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leads" do
    field :email, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(lead, attrs) do
    lead
    |> cast(attrs, [:name, :phone, :email])
    |> validate_required([:name, :phone, :email])
  end
end
