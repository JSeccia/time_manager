defmodule TimeManager.Plug.TeamManager do
  import Plug.Conn

  use TimeManagerWeb, :controller
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if conn.assigns.current_user.role == "admin" do
      conn
    else
      team_id = conn.params["team_id"]

      team =
        try do
          TimeManager.Api.get_team!(team_id)
        rescue
          _e in Ecto.NoResultsError ->
            conn
            |> put_status(:not_found)
            |> render("failure.json", message: "Team not found")
            |> halt()
        end

      IO.inspect(conn.assigns.current_user.id)
      IO.inspect("pipi")
      IO.inspect(team.manager)

      if team.manager != conn.assigns.current_user.id do
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
      else
        conn
      end
    end
  end
end
