use Mix.Config

# Configure your database
config :dashboard_experiment, DashboardExperiment.Repo,
  username: "postgres",
  password: "postgres",
  database: "dashboard_experiment_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dashboard_experiment, DashboardExperimentWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
