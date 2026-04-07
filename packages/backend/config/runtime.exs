import Config

# Hardcoded for docker - in prod use env vars
config :tubbr, TubbrWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  url: [host: "localhost", port: 4000],
  secret_key_base: "dGVzdC1zZWNyZXQta2V5LWJhc2UtZm9yLWRldmVsb3BtZW50LXB1cnBvc2VzLW9ubHkK",  # pragma: allowlist secret
  server: true

config :tubbr, Tubbr.Repo,
  database: "tubbr",
  username: "tubbr",  # pragma: allowlist secret
  password: "tubbr",  # pragma: allowlist secret
  hostname: "postgres",
  pool_size: 10

config :tubbr, Tubbr.PubSub,
  name: Tubbr.PubSub

config :tubbr,
  dns_cluster_query: nil,
  phx_host: "localhost",
  port: 4000
