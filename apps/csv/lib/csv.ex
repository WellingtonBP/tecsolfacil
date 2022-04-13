defmodule Csv do
  @moduledoc """
  Documentation for `Csv`.
  """

  @spec encode([map()], [atom()]) :: binary()
  def encode(lines, headers) do
    csv_header = 
      headers
      |> Enum.map_join(",", &encode_header/1)
      |> Kernel.<>("\n")

    csv_lines = 
      lines
      |> Enum.map_join("\n", &encode_lines(&1, headers))

    csv_header <> csv_lines
  end

  defp encode_header(header) do
    header
    |> to_string()
    |> String.upcase()
  end

  defp encode_lines(line, headers) do
    headers
    |> Enum.map_join(",", fn key -> line[key] end)
  end
end
