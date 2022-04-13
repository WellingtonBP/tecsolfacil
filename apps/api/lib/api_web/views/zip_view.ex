defmodule ApiWeb.ZipView do
  use ApiWeb, :view

  def render("zip.json", %{zip: zip}) do
    zip = Map.from_struct(zip)

    %{
      cep: zip[:cep],
      logradouro: zip[:logradouro],
      complemento: zip[:complemento],
      bairro: zip[:bairro],
      localidade: zip[:localidade],
      uf: zip[:uf],
      ddd: zip[:ddd],
    }
  end
end
