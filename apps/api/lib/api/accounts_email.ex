defmodule Api.AccountsEmail do
  import Swoosh.Email

  def csv(email, csv_path) do
    new()
    |> to(email)
    |> from(System.get_env("EMAIL"))
    |> subject("Adresses CSV File")
    |> text_body("Here is all adresses on database")
    |> attachment(csv_path)
  end
end
