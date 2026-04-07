defmodule Tubbr.Repo.Migrations.CreateCharacterVideos do
  use Ecto.Migration

  def change do
    create table(:character_videos, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :video_id, references(:videos, type: :uuid, on_delete: :delete_all), null: false
      add :character_id, references(:characters, type: :uuid, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:character_videos, [:character_id])
    create index(:character_videos, [:video_id])
    create unique_index(:character_videos, [:character_id, :video_id])
  end
end
