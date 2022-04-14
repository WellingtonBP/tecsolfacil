defmodule Api.ZipCode do
  alias Api.Repo
  alias Api.Worker.SendCsv
  alias Api.ZipCode.Info, as: ZipInfo
  alias Api.ViaCEP.Client, as: ViaCEP

  def get_zipcode_info(zip) do
    db_zip = Repo.get_by(ZipInfo, cep: zip)

    case db_zip do
      nil ->
        zip
        |> ViaCEP.zip_info()
        |> save_zip()

      zip_info ->
        {:ok, zip_info}
    end
  end

  defp save_zip({:ok, response}) do
    %ZipInfo{}
    |> ZipInfo.changeset(response)
    |> Repo.insert()
  end

  defp save_zip(response), do: response

  def send_csv(email) do
    %{email: email}
    |> SendCsv.new()
    |> Oban.insert()
  end
end
