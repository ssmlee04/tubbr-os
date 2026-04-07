defmodule Tubbr.Backend.CharacterImage do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "character_images" do
    field :image_id, :binary_id
    field :character_id, :binary_id

    timestamps()
  end

  def changeset(character_image, attrs) do
    character_image
    |> cast(attrs, [:image_id, :character_id])
    |> validate_required([:image_id, :character_id])
  end
end
