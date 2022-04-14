defmodule Jobs.WorkerSupervisor do
  @moduledoc false
  use DynamicSupervisor

  alias Jobs.Worker

  @me __MODULE__

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_worker do
    {:ok, _} = DynamicSupervisor.start_child(@me, Worker)
  end
end
