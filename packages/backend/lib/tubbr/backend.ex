defmodule Tubbr.Backend do
  alias Tubbr.Repo
  alias Tubbr.Character

  def list_characters do
    Repo.all(Character)
  end

  def get_character!(id) do
    Repo.get!(Character, id)
  end

  def create_character(attrs \\ %{}) do
    %Character{}
    |> Character.changeset(attrs)
    |> Repo.insert()
  end

  def update_character(character, attrs) do
    character
    |> Character.changeset(attrs)
    |> Repo.update()
  end

  def delete_character(character) do
    Repo.delete(character)
  end

  def change_character(character \\ %Character{}) do
    Character.changeset(character, %{})
  end
end
