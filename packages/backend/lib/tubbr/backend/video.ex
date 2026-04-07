defmodule Tubbr.Backend.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "videos" do
    field :user_id, :string
    field :prompt, :string
    field :remote_url, :string
    field :preview_url, :string
    field :aspect_ratio, :string, default: "16:9"
    field :generation_cost, :integer, default: 0
    field :status, :string, default: "pending"
    field :error_message, :string
    field :provider, :string
    field :model, :string
    field :metadata, {:array, :map}, default: []
    field :request_id, :string
    field :is_deleted, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  def changeset(video, attrs) do
    video
    |> cast(attrs, [
      :user_id,
      :prompt,
      :remote_url,
      :preview_url,
      :aspect_ratio,
      :generation_cost,
      :status,
      :error_message,
      :provider,
      :model,
      :metadata,
      :request_id,
      :is_deleted
    ])
    |> validate_required([:user_id])
  end
end
