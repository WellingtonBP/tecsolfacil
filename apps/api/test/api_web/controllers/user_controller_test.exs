defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase

  import Api.UsersFixtures

  alias Api.Token

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "return token for a valid email and password", %{conn: conn} do
      user = create_user()

      conn = post(conn, Routes.user_path(conn, :create), %{email: user.email, password: get_password()})

      assert %{"token" => token} = json_response(conn, 200)
      assert {:ok, id} = Token.verify(token)
      assert id == user.id
    end

    test "return 422 for invalid user and password format", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), %{email: "invalid", password: "invalid"})

      assert %{"errors" => _} = json_response(conn, 422) 
    end

    test "return 401 for invalid user and password", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), %{email: "validformat@email.com", password: "validPass"})

      assert json_response(conn, 401) == %{"message" => "invalid email or password"}
    end
  end
end
