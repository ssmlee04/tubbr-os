defmodule TubbrWeb do
  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: TubbrWeb
      import Plug.Conn
      import Phoenix.Controller, only: [action_fallback: 1]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Plug.Conn
    end
  end

  def static_paths do
    ~w(css fonts images js favicon.ico robots.txt)
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
