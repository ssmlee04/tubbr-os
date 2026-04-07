import Config

# Load .env file for local development (skip if DATABASE_HOST is already set by Docker)
if File.exists?(".env") and System.get_env("DATABASE_HOST") == nil do
  ".env"
  |> File.read!()
  |> String.split("\n")
  |> Enum.reject(&(&1 == "" or String.starts_with?(&1, "#")))
  |> Enum.each(fn line ->
    [key, value] = String.split(line, "=", parts: 2)
    System.put_env(String.trim(key), String.trim(value))
  end)
end

config :tubbr, Tubbr.Repo,
  username: "tubbr",  # pragma: allowlist secret
  password: "tubbr",  # pragma: allowlist secret
  hostname: System.get_env("DATABASE_HOST", "postgres"),
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
