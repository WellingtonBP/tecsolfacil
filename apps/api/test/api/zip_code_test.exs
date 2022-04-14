defmodule Api.ZipCodeTest do
  use Api.DataCase
  import Mock

  alias Api.Repo
  alias Api.ViaCEP.Client
  alias Api.ZipCode
  alias Api.ZipCode.Info

  describe "get_zipcode_info/1" do
    test "fetch zip info from viacep if is not available on database" do
      with_mocks([
        {Repo, [],
         [
           get_by: fn _, _ -> nil end,
           insert: fn data -> {:ok, data} end
         ]},
        {Client, [],
         [
           zip_info: fn _ -> {:ok, %{}} end
         ]},
        {Info, [],
         [
           changeset: fn _, data -> data end
         ]}
      ]) do
        assert ZipCode.get_zipcode_info("00000000") == {:ok, %{}}
      end
    end

    test "fetch zip from database do" do
      with_mock Repo, get_by: fn _, _ -> %{} end do
        assert ZipCode.get_zipcode_info("00000000") == {:ok, %{}}
      end
    end
  end
end
