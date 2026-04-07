# tubbr-backend

Elixir/Phoenix backend for tubbr-os.

## Development

```bash
# Install dependencies
mix deps.get

# Create database and run migrations
mix ecto.setup

# Run the server
mix phx.server
```

## Docker

```bash
docker-compose up --build backend
```
