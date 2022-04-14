defmodule ApiWeb.ZipViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View

  alias Api.ZipCode.Info
  alias ApiWeb.ZipView

  describe "render/2" do
    test "renders zip.json" do
      zip_info = %Info{}

      response =
        zip_info
        |> Map.from_struct()
        |> Map.drop([:__meta__, :inserted_at, :updated_at, :id])

      assert render(ZipView, "zip.json", %{zip: zip_info}) == response
    end

    test "renders csv.json" do
      assert render(ZipView, "csv.json", %{}) == %{message: "csv sent to your email"}
    end
  end
end
