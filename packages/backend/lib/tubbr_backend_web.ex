defmodule TubbrWeb do
  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def static_paths do
    ~w(css fonts images js favicon.ico robots.txt)
  end
end
