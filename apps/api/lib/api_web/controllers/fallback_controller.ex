defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  alias ApiWeb.ErrorView

  def call(conn, {:error, %{errors: errors}}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render("errors.json", errors: errors)
  end

  def call(conn, {:error, :invalid_email_or_password}) do
    conn
    |> put_status(401)
    |> put_view(ErrorView)
    |> render("message.json", message: "invalid email or password")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("message.json", message: "not found")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render("message.json", message: "invalid zip format")
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(ErrorView)
    |> render("message.json", message: "an error occurred")
  end
end
