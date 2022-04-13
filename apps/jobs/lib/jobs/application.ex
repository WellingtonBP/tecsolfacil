defmodule Jobs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Jobs.Scheduler, Application.get_env(:jobs, :worker_count, 5)},
      Jobs.WorkerSupervisor
    ]

    opts = [strategy: :one_for_all, name: Jobs.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
