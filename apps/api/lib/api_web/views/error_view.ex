defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("422.json", %{errors: errors}) do
    %{errors: errors}
  end

  def render("401.json", _) do
    %{message: "invalid email or password"}
  end

  def render("500.json", _) do
     %{message: "Internal Server Error"}
  end
end
