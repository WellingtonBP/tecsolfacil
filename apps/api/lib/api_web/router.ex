defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug ApiWeb.Plug.Authenticate
  end

  scope "/api", ApiWeb do
    pipe_through :api

    post "/auth/login", UserController, :create
  end

  scope "/api", ApiWeb do
    pipe_through [:api, :authenticated]

    get "/zip/:zip_code", ZipController, :show
    get "/zip", ZipController, :index
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
