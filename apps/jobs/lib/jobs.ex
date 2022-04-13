defmodule Jobs do
  @moduledoc """
  Documentation for `Jobs`.
  """

  alias Jobs.Behaviour
  alias Jobs.Scheduler

  defmacro __using__(_) do
    quote do
      @behaviour unquote(Behaviour)

      def new(args) when is_map(args) do
        Scheduler.push_job({&__MODULE__.execute/1, [args]})
      end
    end
  end
end
