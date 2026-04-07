defmodule Tubbr.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :user_id, :string
      add :prompt, :string
      add :remote_url, :string
      add :preview_url, :string
      add :aspect_ratio, :string, default: "1:1"
      add :generation_cost, :integer, default: 0
      add :status, :string, default: "pending"
      add :error_message, :string
      add :provider, :string
      add :model, :string
      add :metadata, {:array, :map}, default: []
      add :request_id, :string
      add :is_deleted, :boolean, default: false

      timestamps(type: :utc_datetime)
    end

    create index(:images, [:user_id])
    create index(:images, [:status])
    create index(:images, [:request_id])
  end
end
