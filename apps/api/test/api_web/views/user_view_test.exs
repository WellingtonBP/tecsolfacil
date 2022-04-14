defmodule ApiWeb.UserViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View

  alias ApiWeb.UserView

  describe "render/2" do
    assert render(UserView, "token.json", %{token: ""}) == %{token: ""}
  end
end
