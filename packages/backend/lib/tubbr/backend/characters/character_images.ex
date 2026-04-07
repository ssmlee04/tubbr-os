defmodule Tubbr.Backend.CharacterImages do
  import Ecto.Query
  alias Tubbr.Repo
  alias Tubbr.Backend.CharacterImage
  alias Tubbr.Backend.Image

  def list_character_images(character_id) do
    CharacterImage
    |> where([ci], ci.character_id == ^character_id)
    |> Repo.all()
  end

  def list_images_with_preload(character_id) do
    character_images = list_character_images(character_id)

    image_ids = Enum.map(character_images, & &1.image_id)

    images = if image_ids != [] do
      Image
      |> where([i], i.id in ^image_ids)
      |> where([i], i.is_deleted == false)
      |> Repo.all()
    else
      []
    end

    images
  end

  def create_character_image(attrs \\ %{}) do
    %CharacterImage{}
    |> CharacterImage.changeset(attrs)
    |> Repo.insert()
  end

  def delete_character_image(character_id, image_id) do
    CharacterImage
    |> where([ci], ci.character_id == ^character_id and ci.image_id == ^image_id)
    |> Repo.one()
    |> case do
      nil -> {:error, :not_found}
      character_image -> Repo.delete(character_image)
    end
  end
end
