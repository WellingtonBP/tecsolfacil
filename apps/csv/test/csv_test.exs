defmodule CsvTest do
  use ExUnit.Case
  doctest Csv

  describe "encode/2" do
    test "should return csv formatted string" do
      headers = [:a, :b, :c]
      lines = [%{a: 20, b: 4, c: 1}, %{a: 3, c: 40}, %{a: 0, b: 107, c: 9}]

      assert Csv.encode(lines, headers) == "A,B,C\n20,4,1\n3,,40\n0,107,9"
    end
  end
end
