defmodule Api.Accounts do
  @moduledoc """
    Accounts Context Functions
  """

  alias Api.Accounts.User
  alias Api.Repo

  @spec create_user(map()) :: {:ok | :error, User.t() | Ecto.Changeset.t()}
  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  @spec get_user_by_email_and_password(binary(), binary()) ::
          {:ok | :error, User.t() | list() | atom()}
  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    errors =
      %User{}
      |> User.changeset(%{email: email, password: password}, check_duplication: false)
      |> User.get_errors_message()

    with nil <- errors,
         user <- Repo.get_by(User, email: email),
         true <- User.valid_password?(user, password) do
      {:ok, user}
    else
      %{errors: _} = r -> {:error, r}
      false -> {:error, :invalid_email_or_password}
    end
  end

  @spec get_user(integer()) :: User.t()
  def get_user(id), do: Repo.get!(User, id)
end
