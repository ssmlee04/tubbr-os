defmodule TubbrWeb.CharacterJSON do
  alias Tubbr.Character

  def index(%{characters: characters}) do
    %{data: for(character <- characters, do: data(character))}
  end

  def show(%{character: character}) do
    %{data: data(character)}
  end

  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  defp data(%Character{} = character) do
    %{
      id: character.id,
      name: character.name,
      description: character.description,
      inserted_at: character.inserted_at,
      updated_at: character.updated_at
    }
  end

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
