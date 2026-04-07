defmodule TubbrWeb.GenerationParamsController do
  use Phoenix.Controller

  @eleven_labs_voices [
    # Male voices (from ElevenLabs)
    %{
      key: "Roger",
      value: "CwhRBWXzGAHq8TQ4Fs17",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/CwhRBWXzGAHq8TQ4Fs17/58ee3ff5-f6f2-4628-93b8-e38eb31806b0.mp3"
    },
    %{
      key: "Charlie",
      value: "IKne3meq5aSn9XLyUdCD",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/IKne3meq5aSn9XLyUdCD/102de6f2-22ed-43e0-a1f1-111fa75c5481.mp3"
    },
    %{
      key: "George",
      value: "JBFqnCBsd6RMkjVDRZzb",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/JBFqnCBsd6RMkjVDRZzb/e6206d1a-0721-4787-aafb-06a6e705cac5.mp3"
    },
    %{
      key: "Callum",
      value: "N2lVS1w4EtoT3dr4eOWO",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/N2lVS1w4EtoT3dr4eOWO/ac833bd8-ffda-4938-9ebc-b0f99ca25481.mp3"
    },
    %{
      key: "Harry",
      value: "SOYHLrjzK2X1ezoPC6cr",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/SOYHLrjzK2X1ezoPC6cr/86d178f6-f4b6-4e0e-85be-3de19f490794.mp3"
    },
    %{
      key: "Liam",
      value: "TX3LPaxmHKxFdv7VOQHJ",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/TX3LPaxmHKxFdv7VOQHJ/63148076-6363-42db-aea8-31424308b92c.mp3"
    },
    %{
      key: "Eric",
      value: "cjVigY5qzO86Huf0OWal",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/cjVigY5qzO86Huf0OWal/d098fda0-6456-4030-b3d8-63aa048c9070.mp3"
    },
    %{
      key: "Chris",
      value: "iP95p4xoKVk53GoZ742B",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/iP95p4xoKVk53GoZ742B/3f4bde72-cc48-40dd-829f-57fbf906f4d7.mp3"
    },
    %{
      key: "Brian",
      value: "nPczCjzI2devNBz1zQrb",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/nPczCjzI2devNBz1zQrb/2dd3e72c-4fd3-42f1-93ea-abc5d4e5aa1d.mp3"
    },
    %{
      key: "Daniel",
      value: "onwK4e9ZLuTAKqWW03F9",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/onwK4e9ZLuTAKqWW03F9/7eee0236-1a72-4b86-b303-5dcadc007ba9.mp3"
    },
    %{
      key: "Adam",
      value: "pNInz6obpgDQGcFmaJgB",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/pNInz6obpgDQGcFmaJgB/d6905d7a-dd26-4187-bfff-1bd3a5ea7cac.mp3"
    },
    %{
      key: "Will",
      value: "bIHbv24MWmeRgasZH58o",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/bIHbv24MWmeRgasZH58o/8caf8f3d-ad29-4980-af41-53f20c72d7a4.mp3"
    },
    %{
      key: "Bill",
      value: "pqHfZKP75CvOlQylNhV4",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/pqHfZKP75CvOlQylNhV4/d782b3ff-84ba-4029-848c-acf01285524d.mp3"
    },
    %{
      key: "Peter",
      value: "GgV5QStPLpmkN7FOHJtY",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/custom/voices/GgV5QStPLpmkN7FOHJtY/bmKBkANSoceD0lpX6ZiA.mp3"
    },
    # Female voices (from ElevenLabs)
    %{
      key: "Sarah",
      value: "EXAVITQu4vr4xnSDxMaL",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/EXAVITQu4vr4xnSDxMaL/01a3e33c-6e99-4ee7-8543-ff2216a32186.mp3"
    },
    %{
      key: "Laura",
      value: "FGY2WhTYpPnrIDTdsKH5",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/FGY2WhTYpPnrIDTdsKH5/67341759-ad08-41a5-be6e-de12fe448618.mp3"
    },
    %{
      key: "Alice",
      value: "Xb7hH8MSUJpSbSDYk0k2",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/Xb7hH8MSUJpSbSDYk0k2/d10f7534-11f6-41fe-a012-2de1e482d336.mp3"
    },
    %{
      key: "Matilda",
      value: "XrExE9yKIg1WjnnlVkGX",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/XrExE9yKIg1WjnnlVkGX/b930e18d-6b4d-466e-bab2-0ae97c6d8535.mp3"
    },
    %{
      key: "Jessica",
      value: "cgSgspJ2msm6clMCkdW9",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/cgSgspJ2msm6clMCkdW9/56a97bf8-b69b-448f-846c-c3a11683d45a.mp3"
    },
    %{
      key: "Bella",
      value: "hpp4J3VqNfWAUOO0d1Us",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/hpp4J3VqNfWAUOO0d1Us/dab0f5ba-3aa4-48a8-9fad-f138fea1126d.mp3"
    },
    %{
      key: "Lily",
      value: "pFZP5JQG7iQjIQuC4Bku",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/pFZP5JQG7iQjIQuC4Bku/89b68b35-b3dd-4348-a84a-a3c13a3c2b30.mp3"
    },
    %{
      key: "River",
      value: "SAz9YHcvj6GT2YYXdXww",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/premade/voices/SAz9YHcvj6GT2YYXdXww/e6c95f0b-2227-491a-b3d7-2249240decb7.mp3"
    },
    %{
      key: "Jessa",
      value: "yj30vwTGJxSHezdAGsv9",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/workspace/1df4b21393b74964b03d3690a173eb80/voices/yj30vwTGJxSHezdAGsv9/vx3tSQ1IkoQyN4rr6olh.mp3"
    },
    %{
      key: "Hope",
      value: "OYTbf65OHHFELVut7v2H",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/workspace/e219aba9bd7442daa87c084f511be4f3/voices/OYTbf65OHHFELVut7v2H/kTLS0DfvlR1QTyjUzOiT.mp3"
    },
    %{
      key: "Ashe",
      value: "jL3B7UpQr35XUDP9eWCS",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/workspace/55c3cc27bc2344d5a85b974438326188/voices/jL3B7UpQr35XUDP9eWCS/5tTviDywIESA6vPDfUDZ.mp3"
    },
    %{
      key: "Siren",
      value: "eXpIbVcVbLo8ZJQDlDnl",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/workspace/cbfaa74d559547979fa92c07eae49b0f/voices/eXpIbVcVbLo8ZJQDlDnl/nvbKCMRoZnwNqgIhVjJE.mp3"
    },
    %{
      key: "Arabella",
      value: "aEO01A4wXwd1O8GPgGlF",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/user/rXPvBAYLgtWWSz1trBzQCzJldqC2/voices/aEO01A4wXwd1O8GPgGlF/B0TnT9nA9kj4OFUzZ3BQ.mp3"
    },
    %{
      key: "Grandma Rachel",
      value: "0rEo3eAjssGDUCXHYENf",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/workspace/c935179a13664dd5973856334856f7a3/voices/0rEo3eAjssGDUCXHYENf/OanmjvkLzBwStr5TO2Xb.mp3"
    },
    %{
      key: "Beatrice",
      value: "kkPJzQOWz2Oz9cUaEaQd",
      preview_url:
        "https://storage.googleapis.com/eleven-public-prod/database/user/TUDoNu7zcHRc4xA6pOaScRyMvni2/voices/kkPJzQOWz2Oz9cUaEaQd/D89YvNPOU9wk5ykb0ysz.mp3"
    }
  ]

  def index(conn, _params) do
    json(conn, %{
      params: %{
        image: %{
          providers: [
            %{
              name: "Replicate",
              id: "replicate",
              models: [
                %{
                  id: "bytedance/seedream-5-lite",
                  name: "Seedream 5 Lite",
                  params: [
                    %{
                      name: "prompt",
                      type: "string",
                      optional: false,
                      label: "Prompt",
                      description: "Text description of the image"
                    },
                    %{
                      name: "image_input",
                      type: "file",
                      multi: true,
                      optional: true,
                      label: "Image Input (If this is empty, it will look up character names in your prompt. It can support up to 3 characters)",
                      description: "Multiple reference images (up to 2 images)"
                    },
                    %{
                      name: "size",
                      type: "select",
                      optional: true,
                      default: "2K",
                      options: [%{key: "2K", value: "2K"}, %{key: "3K", value: "3K"}],
                      label: "Resolution",
                      description: "Output resolution (2K or 3K)"
                    },
                    %{
                      name: "aspect_ratio",
                      type: "select",
                      optional: true,
                      default: "1:1",
                      options: [
                        %{key: "1:1", value: "1:1"},
                        %{key: "16:9", value: "16:9"},
                        %{key: "9:16", value: "9:16"}
                      ],
                      label: "Aspect Ratio",
                      description: "Image aspect ratio"
                    }
                  ]
                }
              ]
            }
          ]
        },
        video: %{
          providers: [
            %{
              name: "xAI",
              models: [
                %{
                  id: "xai/grok-imagine-video",
                  name: "Grok Imagine Video",
                  params: [
                    %{
                      name: "prompt",
                      type: "string",
                      optional: false,
                      label: "Prompt",
                      description: "Text description of the video"
                    },
                    %{
                      name: "image",
                      type: "file",
                      optional: true,
                      label: "Input Image",
                      description: "Input image to animate (base64)"
                    },
                    %{
                      name: "aspect_ratio",
                      type: "select",
                      optional: false,
                      default: "16:9",
                      options: [
                        %{key: "1:1", value: "1:1"},
                        %{key: "16:9", value: "16:9"},
                        %{key: "9:16", value: "9:16"}
                      ],
                      label: "Aspect Ratio",
                      description: "Video aspect ratio"
                    },
                    %{
                      name: "duration",
                      type: "select",
                      optional: true,
                      default: 3,
                      options: [
                        %{key: 2, value: 2},
                        %{key: 3, value: 3},
                        %{key: 4, value: 4},
                        %{key: 5, value: 5},
                        %{key: 6, value: 6},
                        %{key: 7, value: 7},
                        %{key: 8, value: 8}
                      ],
                      label: "Duration",
                      description: "Video duration in seconds"
                    }
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
                  id: "eleven_multilingual_v2",
                  name: "Eleven Multilingual v2",
                  params: [
                    %{
                      name: "prompt",
                      type: "string",
                      optional: false,
                      label: "Prompt",
                      description: "Text description of the audio"
                    },
                    %{
                      name: "voice_id",
                      type: "select",
                      optional: true,
                      has_voice_preview_url: true,
                      default: Enum.at(@eleven_labs_voices, 0).value,
                      options: @eleven_labs_voices,
                      label: "Voice Id",
                      description: "Voice Id"
                    }
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
