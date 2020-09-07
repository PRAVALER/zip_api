defmodule ZipApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ZipApi.Repo,
      # Start the Telemetry supervisor
      ZipApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ZipApi.PubSub},
      # Start the Endpoint (http/https)
      ZipApiWeb.Endpoint
      # Start a worker by calling: ZipApi.Worker.start_link(arg)
      # {ZipApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ZipApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ZipApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
