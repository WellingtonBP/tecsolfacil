defmodule Api.UsersFixtures do

  alias Api.Accounts

  def create_user do
    {:ok, user} = 
      %{
        email: "test@email.com",
        password: "Test1P4ss"
      }
      |> Accounts.create_user()

    user
  end

end
