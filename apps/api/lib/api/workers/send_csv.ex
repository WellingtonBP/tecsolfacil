defmodule Api.Worker.SendCsv do
	#	use Jobs
	use Oban.Worker,
		queue: :zip_csv,
		max_attempts: 5

	alias Api.AccountsEmail
	alias Api.Mailer
	alias Api.Repo
	alias Api.ZipCode.Info

	@csv_header [:bairro, :cep, :complemento, :ddd, :localidade, :logradouro, :uf, :inserted_at, :updated_at]

	#def execute(%{email: email}) do
	@impl Oban.Worker
	def perform(%Oban.Job{args: %{"email" => email}}) do
		with filepath <- get_filepath(),
				 csv_str <- get_csv_str(),
				 :ok <- File.write(filepath, csv_str) do
			resp = 
				email
				|> AccountsEmail.csv(filepath)
				|> Mailer.deliver() 

			File.rm(filepath)
			resp
		else
			error ->
				{:error, error}
		end
	end

	defp get_csv_str do
		Info
		|> Repo.all()
		|> Enum.map(&Map.from_struct/1)
		|> Csv.encode(@csv_header)
	end

	defp get_filepath do
		Application.get_env(:api, :csv_tmp_dir)
		|> Kernel.<>("/#{get_date_str()}.csv")
	end

	defp get_date_str do
		DateTime.utc_now()
		|> to_string()
	end
end
