defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("errors.json", %{errors: errors}) do
    %{errors: errors}
  end

  def render("message.json", %{message: message}) do
    %{message: message}
  end
end
