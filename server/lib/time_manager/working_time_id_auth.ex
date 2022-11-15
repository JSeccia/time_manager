defmodule TimeManager.Plug.WorkingTimeIdAuth do
  import Plug.Conn

  use TimeManagerWeb, :controller
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    working_time = TimeManager.Api.get_working_time!(conn.params["id"])
    user = TimeManager.Api.get_user!(working_time.user_id)

    case conn.assigns.current_user.role do
      "admin" ->
        conn

      "manager" ->
        team = TimeManager.Api.get_team!(user.team_id)

        if team.manager == conn.assigns.current_user.id do
          conn
        else
          conn
          |> put_status(:unauthorized)
          |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
          |> Phoenix.Controller.render(:"401")
          |> halt()
        end

      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end
