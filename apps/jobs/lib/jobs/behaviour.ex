defmodule Jobs.Behaviour do
  @moduledoc false
  @callback execute(any()) :: :ok | {:ok, any()}
end
