defmodule Api.AccountsTest do
  use Api.DataCase

  alias Api.Accounts

  import Api.UsersFixtures

  describe "get_user_by_email_and_password/2" do
    test "should return user when valid email and password" do
      user = create_user()

      assert {:ok, _} = Accounts.get_user_by_email_and_password(user.email, user.password)
    end

    test "shoud return error for non-existing user" do
      assert {:error, :invalid_email_or_password} =
               Accounts.get_user_by_email_and_password("notfound@email.com", "Ud92jd29")
    end

    test "shoud return error for invalid email or password format" do
      assert {:error, errors} = Accounts.get_user_by_email_and_password("notemail", "notpass")
      assert is_map(errors)
    end
  end

  describe "get_user/1" do
    test "should return user for a valid id" do
      user = create_user()

      assert user_res = Accounts.get_user(user.id)
      assert user_res.email == user.email
    end

    test "shoud raise an error for invalid id" do
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user(-1) end
    end
  end
end
