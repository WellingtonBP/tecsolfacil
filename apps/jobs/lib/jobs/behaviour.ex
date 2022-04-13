defmodule Jobs.Behaviour do
  @callback execute(any()) :: :ok | {:ok, any()}
end
