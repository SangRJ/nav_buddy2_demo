defmodule NavBuddy2Demo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NavBuddy2DemoWeb.Telemetry,
      NavBuddy2Demo.Repo,
      {DNSCluster, query: Application.get_env(:nav_buddy2_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NavBuddy2Demo.PubSub},
      # Start a worker by calling: NavBuddy2Demo.Worker.start_link(arg)
      # {NavBuddy2Demo.Worker, arg},
      # Start to serve requests, typically the last entry
      NavBuddy2DemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NavBuddy2Demo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NavBuddy2DemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
