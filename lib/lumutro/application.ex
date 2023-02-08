defmodule Lumutro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LumutroWeb.Telemetry,
      # Start the Ecto repository
      Lumutro.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lumutro.PubSub},
      # Start Finch
      {Finch, name: Lumutro.Finch},
      # Start the Endpoint (http/https)
      LumutroWeb.Endpoint
      # Start a worker by calling: Lumutro.Worker.start_link(arg)
      # {Lumutro.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lumutro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LumutroWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
