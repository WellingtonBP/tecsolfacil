defmodule Api.Repo.Migrations.CreateZipinfoTable do
  use Ecto.Migration

  def change do
    create table(:zipcode) do
      add :cep, :string, null: false
      add :localidade, :string, null: false
      add :uf, :string, null: false
      add :logradouro, :string
      add :complemento, :string
      add :bairro, :string
      add :ddd, :string

      timestamps()
    end

    create unique_index(:zipcode, [:cep])
  end
end
