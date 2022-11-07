defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Api
  alias TimeManager.Api.Team
  alias TimeManager.Api.User
  require Logger

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, _params) do
    teams = Api.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    Logger.warn(conn.assigns.current_user)

    with {:ok, %Team{} = team} <- Api.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def add_user(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    try do
      team = Api.get_team!(team_id)
      user = Api.get_user!(user_id)

      if Map.has_key?(user, :team) && user.team == String.to_integer(team_id) do
        conn
        |> put_status(:bad_request)
        |> render("failure.json", message: "User already in team")
      else
        user = Api.update_user_team(user, %{team: team_id})
        render(conn, "show.json", team: team)
      end
    rescue
      e in Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> render("failure.json", message: "Team or user not found")
    end
  end

  def show(conn, %{"id" => id}) do
    team = Api.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Api.get_team!(id)

    with {:ok, %Team{} = team} <- Api.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Api.get_team!(id)

    with {:ok, %Team{}} <- Api.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
