defmodule TubbrWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :tubbr

  plug Plug.Static,
    at: "/",
    from: :tubbr,
    gzip: false,
    only: TubbrWeb.static_paths()

  plug CORSPlug, origin: "*"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head
  plug TubbrWeb.Router
end
