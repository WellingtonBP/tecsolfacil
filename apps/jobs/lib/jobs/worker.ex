defmodule Jobs.Worker do
  use GenServer

  alias Jobs.Scheduler

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    Process.send_after(self(), :process_job, 0)
    {:ok, nil}
  end

  def handle_info(:process_job, _) do
    Scheduler.next_job()
    |> process_job()

    send(self(), :process_job)
    {:noreply, nil}
  end

  defp process_job({fun, args}), do: apply(fun, args)
  defp process_job(nil), do: Process.sleep(1000)
end
