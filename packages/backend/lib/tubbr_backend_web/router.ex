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

    get "/characters", CharacterController, :index
    get "/characters/:id", CharacterController, :show
    post "/characters", CharacterController, :create
    patch "/characters/:id", CharacterController, :update
    put "/characters/:id", CharacterController, :update
    delete "/characters/:id", CharacterController, :delete
  end
end
