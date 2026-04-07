defmodule TubbrWeb.GenerationParamsController do
  use TubbrWeb, :controller

  def index(conn, _params) do
    json(conn, %{
      params: %{
        image: %{
          providers: [
            %{
              name: "Replicate",
              models: [
                %{
                  id: "black-forest-labs/flux-1.1-pro",
                  name: "FLUX 1.1 Pro",
                  params: [
                    %{ name: "prompt", type: "string", label: "Prompt", required: true },
                    %{ name: "aspect_ratio", type: "select", label: "Aspect Ratio", options: ["1:1", "16:9", "9:16", "4:3", "3:4"], default: "1:1" },
                    %{ name: "guidance_scale", type: "number", label: "Guidance Scale", default: 3.5 },
                    %{ name: "num_inference_steps", type: "number", label: "Inference Steps", default: 28 }
                  ]
                },
                %{
                  id: "black-forest-labs/flux-schnell",
                  name: "FLUX Schnell",
                  params: [
                    %{ name: "prompt", type: "string", label: "Prompt", required: true },
                    %{ name: "aspect_ratio", type: "select", label: "Aspect Ratio", options: ["1:1", "16:9", "9:16"], default: "1:1" },
                    %{ name: "num_inference_steps", type: "number", label: "Inference Steps", default: 4 }
                  ]
                }
              ]
            },
            %{
              name: "Seedream",
              models: [
                %{
                  id: "seedream/seedream-5-lite",
                  name: "Seedream 5 Lite",
                  params: [
                    %{ name: "prompt", type: "string", label: "Prompt", required: true },
                    %{ name: "aspect_ratio", type: "select", label: "Aspect Ratio", options: ["1:1", "16:9", "9:16"], default: "1:1" }
                  ]
                }
              ]
            }
          ]
        },
        video: %{
          providers: [
            %{
              name: "Kling",
              models: [
                %{
                  id: "kling-2.5-turbo",
                  name: "Kling 2.5 Turbo",
                  params: [
                    %{ name: "prompt", type: "string", label: "Prompt", required: true },
                    %{ name: "duration", type: "select", label: "Duration", options: ["5s", "10s"], default: "5s" }
                  ]
                }
              ]
            },
            %{
              name: "Seedance",
              models: [
                %{
                  id: "seedance-1-lite",
                  name: "Seedance 1 Lite",
                  params: [
                    %{ name: "prompt", type: "string", label: "Prompt", required: true }
                  ]
                }
              ]
            }
          ]
        },
        audio: %{
          providers: [
            %{
              name: "ElevenLabs",
              models: [
                %{
                  id: "eleven-multilingual-v2",
                  name: "ElevenLabs Multilingual v2",
                  params: [
                    %{ name: "text", type: "string", label: "Text", required: true },
                    %{ name: "voice_id", type: "string", label: "Voice ID", required: true }
                  ]
                }
              ]
            }
          ]
        }
      }
    })
  end
end
