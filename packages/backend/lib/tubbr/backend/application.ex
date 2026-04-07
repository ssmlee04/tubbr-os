defmodule Tubbr.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Tubbr.Repo,
      {Phoenix.PubSub, name: Tubbr.PubSub},
      {DNSCluster, query: Application.get_env(:tubbr, :dns_cluster_query) || :ignore},
      TubbrWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Tubbr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    TubbrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
