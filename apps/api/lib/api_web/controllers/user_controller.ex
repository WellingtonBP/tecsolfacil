defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Token

  action_fallback ApiWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.get_user_by_email_and_password(email, password),
         {:ok, token} <- Token.sign(user) do
      render(conn, "token.json", token: token)
    end
  end
end
