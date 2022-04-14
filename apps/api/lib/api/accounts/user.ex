defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Repo

  @email_regex ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_email(opts)
    |> validate_password()
  end

  defp validate_email(changeset, opts) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, @email_regex, message: "invalid email")
    |> check_email_duplication(Keyword.get(opts, :check_duplication, true))
    |> unique_constraint(:email)
  end

  defp check_email_duplication(changeset, true) do
    changeset
    |> unsafe_validate_unique(:email, Repo)
  end

  defp check_email_duplication(changeset, _), do: changeset

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 32)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    changeset
    |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
  end

  def valid_password?(%__MODULE__{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _), do: false

  def get_errors_message(changeset) do
    if !changeset.valid? do
      errors =
        changeset.errors
        |> Map.new(fn {key, {message, meta}} ->
          {key, interpolation(message, meta)}
        end)

      %{errors: errors}
    else
      nil
    end
  end

  defp interpolation(message, meta) do
    ~r/(?<head>)%{[^}]+}(?<tail>)/
    |> Regex.split(message, on: [:head, :tail])
    |> Enum.reduce("", fn
      <<"%{" <> rest>>, acc ->
        key = String.trim_trailing(rest, "}") |> String.to_atom()
        value = Keyword.fetch!(meta, key)
        acc <> to_string(value)

      segment, acc ->
        acc <> segment
    end)
  end
end
