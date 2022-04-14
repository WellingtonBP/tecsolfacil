defmodule Api.Token do
  @moduledoc """
    Generate and decode token
  """
  @signing_salt System.get_env("PHX_TOKEN_SALT")
  @token_age_secs 24 * 3600

  @spec sign(Api.Accounts.User.t()) :: {:ok, binary()}
  def sign(user) do
    token = Phoenix.Token.sign(ApiWeb.Endpoint, @signing_salt, user.id)
    {:ok, token}
  end

  @spec verify(binary()) :: {:ok | :error, binary() | atom()}
  def verify(token) do
    case Phoenix.Token.verify(ApiWeb.Endpoint, @signing_salt, token, max_age: @token_age_secs) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthenticated}
    end
  end
end
