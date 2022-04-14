defmodule ApiWeb.ZipControllerTest do
  use ApiWeb.ConnCase
 
  import Mock
  import Api.UsersFixtures

  alias Api.Token
  alias Api.ZipCode
  alias Api.ZipCode.Info
 
  setup %{conn: conn} do
    conn = 
      create_user()
      |> Token.sign()
      |> elem(1)
      |> (&put_req_header(conn, "authorization", "Bearer #{&1}")).()
      |> put_req_header("accept", "application/json")

    {:ok, conn: conn}
  end

  describe "show/2" do
    test "return address for a valid zip code", %{conn: conn} do
      resp = 
        %Info{}
        |> Map.from_struct()
        |> Map.drop([:__meta__, :inserted_at, :updated_at, :id])
        |> Map.new(fn {key, value} -> {to_string(key), value} end)

      with_mock ZipCode, [get_zipcode_info: fn _ -> {:ok, %Info{}} end] do
        conn = get(conn, Routes.zip_path(conn, :show, "validzip"))

        assert json_response(conn, 200) == resp
      end
    end

    test "return 404 for non-existing zip code", %{conn: conn} do
      with_mock ZipCode, [get_zipcode_info: fn _ -> {:error, :not_found} end] do
        conn = get(conn, Routes.zip_path(conn, :show, "notfoundzip"))

        assert json_response(conn, 404) == %{"message" => "not found"}
      end
    end

    test "return 422 for invalid zip code format", %{conn: conn} do
      with_mock ZipCode, [get_zipcode_info: fn _ -> {:error, :bad_request} end] do
        conn = get(conn, Routes.zip_path(conn, :show, "notfoundzip"))

        assert json_response(conn, 422) == %{"message" => "invalid zip format"}
      end
    end

    test "return 401 for unauthenticated user", %{conn: conn} do
      conn =
        conn
        |> delete_req_header("authorization")
        |> get(Routes.zip_path(conn, :show, "zip"))

      assert json_response(conn, 401) == %{"message" => "unauthenticated"}
    end
  end

  describe "index/2" do
    test "return csv sent message", %{conn: conn} do
      with_mock ZipCode, [send_csv: fn _ -> nil end] do
        conn = get(conn, Routes.zip_path(conn, :index))

        assert json_response(conn, 200) == %{"message" => "csv sent to your email"}
      end
    end

    test "return 401 for unauthenticated user", %{conn: conn} do
      conn =
        conn
        |> delete_req_header("authorization")
        |> get(Routes.zip_path(conn, :index))

      assert json_response(conn, 401) == %{"message" => "unauthenticated"}
    end
  end
end
