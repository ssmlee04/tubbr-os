defmodule Tubbr.Backend.CharacterVideo do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "character_videos" do
    field :video_id, :binary_id
    field :character_id, :binary_id

    timestamps()
  end

  def changeset(character_video, attrs) do
    character_video
    |> cast(attrs, [:video_id, :character_id])
    |> validate_required([:video_id, :character_id])
  end
end
