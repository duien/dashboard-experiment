defmodule DashboardExperimentWeb.WebhookController do
  use DashboardExperimentWeb, :controller

  def github(conn, _params) do
    json(conn, %{})
  end
end
