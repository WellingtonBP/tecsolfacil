import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :api, Api.Repo,
  username: "pgdbuser",
  password: "pgdbpass",
  hostname: "localhost",
  database: "api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# disable oban plugins and queues for tests
config :api, Oban, queues: false, plugins: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api, ApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "DFwJeK5C5dPSFyL/x53+EhcEZJCNO3DHxr9xbPu4PGewT+LhEkOAWwaaIi8Tn7Ni",
  server: false

# Tesla Mock
config :tesla, adapter: Tesla.Mock

# In test we don't send emails.
config :api, Api.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
