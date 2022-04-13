defmodule Jobs.Scheduler do
  use GenServer

  alias Jobs.WorkerSupervisor

  @me __MODULE__

  def start_link(worker_count) do
    GenServer.start_link(__MODULE__, worker_count, name: @me)
  end

  def next_job() do
    GenServer.call(@me, :next_job)
  end 
  
  def push_job(job) do
    GenServer.cast(@me, {:push, job})
  end

  def init(worker_count) do
    Process.send_after(self(), :start_workers, 0)
    {:ok, worker_count}
  end

  def handle_info(:start_workers, worker_count) do
    1..worker_count
    |> Enum.each(fn _ -> WorkerSupervisor.start_worker() end)

    {:noreply, []}
  end

  def handle_call(:next_job, _, jobs) do
    {job, jobs} = List.pop_at(jobs, -1)

    {:reply, job, jobs}
  end

  def handle_cast({:push, job}, jobs) do
    {:noreply, [job | jobs]}
  end
end
