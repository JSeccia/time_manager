defmodule TimeManager.Plug.UserManager do
  import Plug.Conn

  use TimeManagerWeb, :controller
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user_id = conn.params["user_id"]

    if conn.assigns.current_user.role == "admin" do
      conn
    else
      user =
        try do
          TimeManager.Api.get_user!(user_id)
        rescue
          _e in Ecto.NoResultsError ->
            conn
            |> put_status(:not_found)
            |> render("failure.json", message: "User not found")
            |> halt()
        end

      team =
        try do
          TimeManager.Api.get_team!(user.team_id)
        rescue
          _e in Ecto.NoResultsError ->
            conn
            |> put_status(:not_found)
            |> render("failure.json", message: "User not in a team")
            |> halt()
        end

      if team.manager != conn.assigns.current_user.id &&
           String.to_integer(user_id) != conn.assigns.current_user.id do
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
