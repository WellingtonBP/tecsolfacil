defmodule ApiWeb.ZipController do
  use ApiWeb, :controller

  alias Api.ZipCode

  action_fallback ApiWeb.FallbackController

  def show(conn, %{"zip_code" => zip}) do
    with {:ok, zip_info} <- ZipCode.get_zipcode_info(zip) do
      render(conn, "zip.json", zip: zip_info)
    end
  end

  def index(conn, _) do
    conn.assigns.current_user.email
    |> ZipCode.send_csv()

    conn
    |> render("csv.json")
  end
end
