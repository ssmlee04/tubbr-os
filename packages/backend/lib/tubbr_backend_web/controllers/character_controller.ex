defmodule TubbrWeb.CharacterController do
  use Phoenix.Controller

  alias Tubbr.Backend

  action_fallback TubbrWeb.FallbackController

  def index(conn, _params) do
    characters = Backend.list_characters()
    json(conn, %{data: Enum.map(characters, &character_to_map/1)})
  end

  def create(conn, %{"character" => character_params}) do
    case Backend.create_character(character_params) do
      {:ok, character} ->
        conn
        |> put_status(:created)
        |> json(%{data: character_to_map(character)})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: format_errors(changeset)})
    end
  end

  def show(conn, %{"id" => id}) do
    character = Backend.get_character!(id)
    json(conn, %{data: character_to_map(character)})
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Backend.get_character!(id)

    case Backend.update_character(character, character_params) do
      {:ok, character} ->
        json(conn, %{data: character_to_map(character)})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: format_errors(changeset)})
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Backend.get_character!(id)
    {:ok, _character} = Backend.delete_character(character)
    send_resp(conn, :no_content, "")
  end

  defp character_to_map(%Tubbr.Character{} = character) do
    %{
      id: character.id,
      name: character.name,
      description: character.description,
      default_image_prompt: character.default_image_prompt,
      default_video_prompt: character.default_video_prompt,
      default_voice_prompt: character.default_voice_prompt,
      inserted_at: character.inserted_at,
      updated_at: character.updated_at
    }
  end

  defp format_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
