use Mix.Config

# Configure your database
config :worte, Worte.Repo,
  username: "postgres",
  password: "postgres",
  database: "worte_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :worte, WorteWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
