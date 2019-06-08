defmodule DashboardExperimentWeb.WebhookController do
  use DashboardExperimentWeb, :controller

  plug :validate_github_token when action in [:github]

  def github(conn, _params) do
    json(conn, conn.req_headers)
  end

  defp validate_github_token(conn, _) do
    # IO.inspect(conn.req_headers)
    # conn
    # |> get_req_header('x_hub_signature')


    conn
  end
end
