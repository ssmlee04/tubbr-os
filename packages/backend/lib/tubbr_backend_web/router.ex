defmodule TubbrWeb.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TubbrWeb do
    pipe_through :api

    get "/health", HealthController, :index
  end

  scope "/api", TubbrWeb do
    pipe_through :api
  end
end
