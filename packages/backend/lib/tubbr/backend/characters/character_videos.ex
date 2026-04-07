defmodule Tubbr.Backend.CharacterVideos do
  import Ecto.Query
  alias Tubbr.Repo
  alias Tubbr.Backend.CharacterVideo
  alias Tubbr.Backend.Video

  def list_character_videos(character_id) do
    CharacterVideo
    |> where([cv], cv.character_id == ^character_id)
    |> Repo.all()
  end

  def list_videos_with_preload(character_id) do
    character_videos = list_character_videos(character_id)

    video_ids = Enum.map(character_videos, & &1.video_id)

    videos = if video_ids != [] do
      Video
      |> where([v], v.id in ^video_ids)
      |> where([v], v.is_deleted == false)
      |> Repo.all()
    else
      []
    end

    videos
  end

  def create_character_video(attrs \\ %{}) do
    %CharacterVideo{}
    |> CharacterVideo.changeset(attrs)
    |> Repo.insert()
  end

  def delete_character_video(character_id, video_id) do
    CharacterVideo
    |> where([cv], cv.character_id == ^character_id and cv.video_id == ^video_id)
    |> Repo.one()
    |> case do
      nil -> {:error, :not_found}
      character_video -> Repo.delete(character_video)
    end
  end
end
