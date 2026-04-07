defmodule Tubbr.Character do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "characters" do
    field :name, :string
    field :description, :string
    field :default_image_prompt, :string
    field :default_video_prompt, :string
    field :default_voice_prompt, :string
    timestamps()
  end

  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :description, :default_image_prompt, :default_video_prompt, :default_voice_prompt])
    |> validate_required([:name])
  end
end
