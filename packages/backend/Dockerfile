# Build stage
FROM elixir:1.15 AS build

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

# Prepare build directory
WORKDIR /app

# Copy mix files
COPY mix.exs mix.lock .formatter.exs .tool-versions ./
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy dependencies
COPY priv priv
COPY config config
RUN mix deps.get
RUN mix deps.compile

# Copy app code
COPY lib lib

# Build the app
RUN mix compile

# Create release
RUN mix release

# Runtime stage
FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    inotify-tools \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /app/_build/prod/rel/tubbr ./

RUN chmod +x bin/tubbr

ENV HOME=/app
ENV MIX_ENV=prod
ENV PORT=4000

EXPOSE 4000

CMD ["bin/tubbr", "start"]
