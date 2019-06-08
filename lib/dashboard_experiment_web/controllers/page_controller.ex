defmodule DashboardExperimentWeb.PageController do
  use DashboardExperimentWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
