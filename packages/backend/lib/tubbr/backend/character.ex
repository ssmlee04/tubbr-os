defmodule Tubbr.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field :name, :string
    field :description, :string
    timestamps()
  end

  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
