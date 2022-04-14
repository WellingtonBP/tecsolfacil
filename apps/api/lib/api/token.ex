defmodule Api.Token do
  @signing_salt Application.get_env(:api, :phx_token_salt)
  @token_age_secs 24 * 3600

  def sign(user) do
    token = Phoenix.Token.sign(ApiWeb.Endpoint, @signing_salt, user.id)
    {:ok, token}
  end


  def verify(token) do
    case Phoenix.Token.verify(ApiWeb.Endpoint, @signing_salt, token,
             max_age: @token_age_secs
           ) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthenticated}
    end
  end
end
