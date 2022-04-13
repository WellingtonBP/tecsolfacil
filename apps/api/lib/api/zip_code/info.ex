defmodule Api.ZipCode.Info do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :cep, :string
    field :localidade, :string
    field :uf, :string
    field :logradouro, :string
    field :complemento, :string
    field :bairro, :string
    field :ddd, :string

    timestamps()
  end

  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:cep, :localidade, :uf, :logradouro, :complemento, :bairro, :ddd])
    |> validate_required([:cep, :localidade, :uf])
    |> format_zip()
  end

  def format_zip(changeset) do
    zip = 
      changeset.changes.cep
      |> String.replace("-", "")
   
    changeset
    |> put_change(:cep, zip)
  end
end
