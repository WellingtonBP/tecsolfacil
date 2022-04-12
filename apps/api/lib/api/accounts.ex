defmodule Api.Accounts do
	  alias Api.Accounts.User
	  alias Api.Repo

	  def get_user_by_email_and_password(email, password)
	      when is_binary(email) and is_binary(password) do

      errors = 
        %User{}
        |> User.changeset(%{email: email, password: password})
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
	end
