defmodule ApiWeb.ErrorViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View

  alias ApiWeb.ErrorView

  describe "render/2" do
    test "renders errors.json" do
      assert render(ErrorView, "errors.json", %{errors: []}) == %{errors: []}
    end

    test "renders message.json" do
      assert render(ErrorView, "message.json", %{message: "message"}) == %{message: "message"}
    end
  end
end
