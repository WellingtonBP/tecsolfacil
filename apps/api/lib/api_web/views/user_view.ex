defmodule ApiWeb.UserView do
  use ApiWeb, :view

  def render("token.json", %{token: token}) do
    %{
      token: token
    }
  end
end
