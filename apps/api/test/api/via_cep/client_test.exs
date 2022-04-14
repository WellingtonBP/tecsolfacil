defmodule Api.ViaCEP.ClientTest do
  use Api.DataCase

  alias Api.ViaCEP.Client

  describe "zip_info/1" do
    test "return address for existing zip code" do
      Tesla.Mock.mock(fn %{method: :get} -> %Tesla.Env{status: 200, body: %{}} end)

      assert {:ok, %{}} = Client.zip_info("00000000")
    end

    test "return :not_found for non-existing zip code" do
      Tesla.Mock.mock(fn %{method: :get} -> %Tesla.Env{status: 200, body: %{"erro" => "true"}} end)

      assert {:error, :not_found} = Client.zip_info("99999999")
    end

    test "return :bad_request for invalid zip code format" do
      Tesla.Mock.mock(fn %{method: :get} -> %Tesla.Env{status: 400} end)

      assert {:error, :bad_request} = Client.zip_info("00")
    end
  end
end
