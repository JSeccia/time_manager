defmodule TimeManager.Plug.Admin do
  import Plug.Conn

  use TimeManagerWeb, :controller
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    Logger.info("Admin plug called")

    with {:ok, is_admin} <- TimeManager.Api.is_user_admin?(conn.assigns.current_user.id) do
      conn
    else
      error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end
