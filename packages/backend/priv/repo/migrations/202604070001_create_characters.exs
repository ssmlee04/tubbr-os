defmodule Tubbr.Repo.Migrations.RecreateCharactersWithUuid do
  use Ecto.Migration

  def change do
    drop_if_exists table(:characters)

    create table(:characters, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :name, :string
      add :description, :text
      add :default_image_prompt, :string
      add :default_video_prompt, :string
      add :default_voice_prompt, :string
      timestamps()
    end
  end
end
