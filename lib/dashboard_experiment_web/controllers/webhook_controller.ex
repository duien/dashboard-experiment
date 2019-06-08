defmodule DashboardExperimentWeb.WebhookController do
  use DashboardExperimentWeb, :controller

  def github(conn, _params) do
    json(conn, %{hello: "world"})
  end
end
