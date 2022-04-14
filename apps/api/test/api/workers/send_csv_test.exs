defmodule Api.Worker.SendCsvTest do
  use Api.DataCase, async: true
  use Oban.Testing, repo: Api.Repo

  import Swoosh.TestAssertions

  alias Api.Worker.SendCsv

  describe "perform/1" do
    @tag disable_on_ci: true
    test "should create csv and sent to email" do
      System.put_env("EMAIL", "sender@email.com")

      assert {:ok, _} = perform_job(SendCsv, %{email: "test@email.com"})
      assert_email_sent(subject: "Addresses CSV File")
    end
  end
end
