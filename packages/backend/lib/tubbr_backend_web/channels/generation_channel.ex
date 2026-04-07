defmodule TubbrWeb.GenerationChannel do
  use Phoenix.Channel

  alias Tubbr.Backend.Characters
  alias Tubbr.Backend.CharacterImages

  require Logger

  @impl true
  def join("generation:" <> _character_id, _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("generate_image", %{"provider" => provider, "model" => model, "params" => params, "character_id" => character_id} = payload, socket) do
    Logger.info("GenerationChannel: Received generate_image - provider: #{provider}, model: #{model}")

    character_id = Ecto.UUID.cast!(character_id)
    request_id = Map.get(payload, "request_id", Ecto.UUID.generate())

    # Validate character exists
    case Characters.get_character!(character_id) do
      character ->
        # Push starting status
        push(socket, "progress", %{
          request_id: request_id,
          status: "starting",
          message: "Starting image generation..."
        })

        # For now, simulate generation - in real implementation, call image generator
        # This is where we'd call the actual generation logic similar to tubbr
        Process.sleep(2000)

        push(socket, "progress", %{
          request_id: request_id,
          status: "completed",
          message: "Image generated!",
          # Placeholder - real impl would have actual URLs
          remote_url: "https://example.com/image.png",
          preview_url: "https://example.com/image_preview.png"
        })

        {:reply, {:ok, %{status: "completed"}}, socket}

      _ ->
        {:reply, {:error, %{error: "Character not found"}}, socket}
    end
  end

  @impl true
  def handle_in("generate_image", payload, socket) do
    Logger.warning("GenerationChannel: Invalid generate_image payload: #{inspect(payload)}")
    {:reply, {:error, %{error: "Invalid payload"}}, socket}
  end

  # Handle video generation
  @impl true
  def handle_in("generate_video", %{"provider" => provider, "model" => model, "params" => params, "character_id" => character_id} = payload, socket) do
    Logger.info("GenerationChannel: Received generate_video - provider: #{provider}, model: #{model}")

    request_id = Map.get(payload, "request_id", Ecto.UUID.generate())

    push(socket, "progress", %{
      request_id: request_id,
      status: "starting",
      message: "Starting video generation..."
    })

    Process.sleep(2000)

    push(socket, "progress", %{
      request_id: request_id,
      status: "completed",
      message: "Video generated!"
    })

    {:reply, {:ok, %{status: "completed"}}, socket}
  end
end
