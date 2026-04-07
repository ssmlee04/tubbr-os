import Config

config :tubbr, Tubbr.Repo,
  username: "tubbr",  # pragma: allowlist secret
  password: "tubbr",  # pragma: allowlist secret
  hostname: "localhost",
  database: "tubbr_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :tubbr, TubbrWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "dGVzdC1zZWNyZXQta2V5LWJhc2UtZm9yLWRldmVsb3BtZW50LXB1cnBvc2VzLW9ubHkK"  # pragma: allowlist secret

config :logger, level: :warn
config :tubbr, :sql_sandbox, []
