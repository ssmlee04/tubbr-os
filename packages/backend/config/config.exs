import Config

config :tubbr,
  ecto_repos: [Tubbr.Repo],
  generators: [timestamp_type: :utc_datetime]

config :tubbr, TubbrWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter

config :tubbr,Tubbr.PubSub,
  name: Tubbr.PubSub,
  distributor: :pg2

config :tubbr, TubbrWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  secret_key_base: "dGVzdC1zZWNyZXQta2V5LWJhc2UtZm9yLWRldmVsb3BtZW50LXB1cnBvc2VzLW9ubHkK",  # pragma: allowlist secret
  server: true

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
