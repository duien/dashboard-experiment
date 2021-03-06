# In this file, we load production configuration and
# secrets from environment variables. You can also
# hardcode secrets, although such is generally not
# recommended and you have to remember to add this
# file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :dashboard_experiment, DashboardExperiment.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

github_webhook_secret =
  System.get_env("GITHUB_WEBHOOK_SECRET") ||
  raise """
  environment variable GITHUB_WEBHOOK_SECRET is missing.
  You can generate one by calling: mix phx.gen.secret
  """

config :dashboard_experiment, DashboardExperimentWeb.Plugs.VerifyHubSignature,
  github_webhook_secret: github_webhook_secret


secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :dashboard_experiment, DashboardExperimentWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base
