defmodule DashboardExperiment.Repo do
  use Ecto.Repo,
    otp_app: :dashboard_experiment,
    adapter: Ecto.Adapters.Postgres
end
