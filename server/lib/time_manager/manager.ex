defmodule TimeManager.Plug.Manager do
  import Plug.Conn
  use TimeManagerWeb, :controller
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if conn.assigns.current_user.role == "manager" || conn.assigns.current_user.role == "admin" do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
      |> Phoenix.Controller.render(:"401")
      |> halt()
    end
  end
end
