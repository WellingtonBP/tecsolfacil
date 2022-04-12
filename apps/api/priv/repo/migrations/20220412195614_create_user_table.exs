defmodule Api.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end

    create index(:users, [:email])
  end
end
