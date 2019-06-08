defmodule DashboardExperimentWeb.Plug.VerifyHubSignature do
  import Plug.Conn

  def init(options), do: options

  def call(%Plug.Conn{} = conn, options = %{path: path}) do
    case conn.request_path do
      ^path ->
        [hub_signature] = get_req_header(conn, 'x-hub-signature')
        {:ok, body, _conn} = Plug.Conn.read_body(conn)

        if verify_signature(body, hub_signature) do
          conn
        else
          conn
          |> put_status(:unauthorized)
          |> halt
        end
      _ ->
        conn
    end
  end

  def call(conn, _), do: conn

  defp github_webhook_secret do
    Application.fetch_env!(:dashboard_experiment, DashboardExperimentWeb.Plugs.VerifyHubSignature, :github_webhook_secret)
  end

  defp verify_signature(request_body, signature_from_header) do
    request_body
    |> compute_signature
    |> Plug.Crypto.secure_compare(signature_from_header)
  end

  defp compute_signature(request_body) do
    "sha1=" <> :crypto.hmac(:sha, github_webhook_secret, request_body)
    |> Base.encode16
    |> String.downcase
  end
end
