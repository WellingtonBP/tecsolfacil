defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  alias ApiWeb.ErrorView

  def call(conn, {:error, %{errors: errors}}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render("422.json", errors: errors)
  end

  def call(conn, {:error, :invalid_email_or_password}) do
    conn
    |> put_status(401)
    |> put_view(ErrorView)
    |> render("401.json" )
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(ErrorView)
    |> render("500.json")
  end
end
