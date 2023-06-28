defmodule Boundary.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BoundaryWeb.Telemetry,
      # Start the Ecto repository
      Boundary.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Boundary.PubSub},
      # Start Finch
      {Finch, name: Boundary.Finch},
      # Start the Endpoint (http/https)
      BoundaryWeb.Endpoint
      # Start a worker by calling: Boundary.Worker.start_link(arg)
      # {Boundary.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Boundary.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BoundaryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
