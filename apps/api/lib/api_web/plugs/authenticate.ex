defmodule ApiWeb.Plug.Authenticate do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, id} <- Api.Token.verify(token) do
      conn
      |> assign(:current_user, Api.Accounts.get_user(id))
    else
      error ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, error)
    end
  end
end
