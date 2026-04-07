defmodule Tubbr.Repo.Migrations.AddPromptFieldsToCharacters do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :default_image_prompt, :string
      add :default_video_prompt, :string
      add :default_voice_prompt, :string
    end
  end
end
