defmodule DashboardExperimentWeb.WebhookController do
  use DashboardExperimentWeb, :controller

  plug :validate_github_token when action in [:github]

  def github(conn, _params) do
    json(conn, conn.req_headers |> Enum.into(%{}))
  end

  defp validate_github_token(conn, _) do
    # IO.inspect(conn.req_headers)
    digest = conn
    |> get_req_header('x-hub-signature')
    |> String.replace_leading("sha1=", "")

    verification = :crypto.hmac(:sha1, System.get_env("GITHUB_WEBHOOK_SECRET"), Plug.Conn.read_body(conn))
    |> Base.encode16
    |> String.downcase

    if digest == verification do
      conn
    else
      conn |> send_resp(401, "Unauthorized") |> halt
    end
  end
end


# :crypto.hmac(:sha256, "key", "The quick brown fox jumps over the lazy dog")
# |> Base.encode16
