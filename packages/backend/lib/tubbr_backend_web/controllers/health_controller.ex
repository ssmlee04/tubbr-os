defmodule TubbrWeb.HealthController do
  use Phoenix.Controller

  def index(conn, _params) do
    text(conn, "OK")
  end
end
