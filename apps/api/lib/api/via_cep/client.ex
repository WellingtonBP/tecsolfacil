defmodule Api.ViaCEP.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def zip_info(zip) do
    get("/#{zip}/json")
    |> handle_response()
  end

	defp handle_response({:ok, %Tesla.Env{body: %{"erro" => "true"}, status: 200}}) do
    {:error, :not_found}
  end
  defp handle_response({:ok, %Tesla.Env{status: 400}}) do
    {:error, :bad_request}
  end
  defp handle_response({:ok, %Tesla.Env{body: body, status: 200}}) do
    {:ok, body}
  end
	defp handle_response(_) do
		{:error, :server_error}
	end
end
