import Config

config :tubbr, Tubbr.Repo,
  username: "tubbr",  # pragma: allowlist secret
  password: "tubbr",  # pragma: allowlist secret
  hostname: "localhost",
  database: "tubbr",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :tubbr, TubbrWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  debug_errors: true,
  secret_key_base: "dGVzdC1zZWNyZXQta2V5LWJhc2UtZm9yLWRldmVsb3BtZW50LXB1cnBvc2VzLW9ubHkK",  # pragma: allowlist secret
  watchers: []

config :tubbr, dev_routes: true
