defmodule ApiWeb.ZipController do
  use ApiWeb, :controller

  alias Api.ZipCode

  action_fallback ApiWeb.FallbackController

  def show(conn, %{"zip_code" => zip}) do
    with {:ok, zip_info} <- ZipCode.get_zipcode_info(zip) do
      render(conn, "zip.json", zip: zip_info)
    end
  end
end
