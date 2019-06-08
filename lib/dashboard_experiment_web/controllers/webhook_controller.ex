defmodule DashboardExperimentWeb.WebhookController do
  use DashboardExperimentWeb, :controller

  plug :validate_github_token when action in [:github]

  def github(conn, _params) do
    json(conn, conn.req_headers |> Enum.into(%{}))
  end

  defp validate_github_token(conn, _) do
    # IO.inspect(conn.req_headers)
    digest = conn
    |> Plug.Conn.get_req_header("x-hub-signature")
    |> Enum.at(0)
    |> String.replace_leading("sha1=", "")

    Application.get_env(:dashboard_experiment, :github_webhook_secret)
    |> IO.inspect

    # {:ok, body, _conn} = Plug.Conn.read_body(conn)

    # IO.inspect(body)

    verification = :crypto.hmac(:sha, Application.get_env(:dashboard_experiment, :github_webhook_secret), conn.assigns[:raw_body])
    |> Base.encode16
    |> String.downcase

    if digest == verification do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{ours: verification, theirs: digest})
      |> halt
    end
  end
end


# :crypto.hmac(:sha256, "key", "The quick brown fox jumps over the lazy dog")
# |> Base.encode16
