defmodule Tubbr.Repo.Migrations.CreateCharacterImages do
  use Ecto.Migration

  def change do
    create table(:character_images, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :image_id, references(:images, type: :uuid, on_delete: :delete_all), null: false
      add :character_id, references(:characters, type: :uuid, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:character_images, [:character_id])
    create index(:character_images, [:image_id])
    create unique_index(:character_images, [:character_id, :image_id])
  end
end
