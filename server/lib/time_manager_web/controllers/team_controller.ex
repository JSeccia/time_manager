defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller
  import Ecto.Query

  alias TimeManager.Repo
  alias TimeManager.Api
  alias TimeManager.Api.Team
  alias TimeManager.Api.User
  require Logger

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, _params) do
    query =
      from(t in Team, inner_join: u in User, as: :user, on: u.team_id == t.id, preload: [users: u])

    teams = Repo.all(query)
    render(conn, "teams.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    Logger.warn(conn.assigns.current_user)

    with {:ok, %Team{} = team} <- Api.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("empty_team.json", team: team)
    end
  end

  def add_user(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    try do
      team =
        Repo.one(
          from(t in Team,
            left_join: u in User,
            on: u.team_id == t.id,
            where: t.id == ^team_id,
            preload: [users: u]
          )
        )

      # team = Api.get_team!(team_id, preload: [:users])
      user = Api.get_user!(user_id)

      if Map.has_key?(user, :team_id) && user.team_id == String.to_integer(team_id) do
        conn
        |> put_status(:bad_request)
        |> render("failure.json", message: "User already in team")
      else
        Api.update_user_team(user, %{team_id: team_id})

        team =
          Repo.one(
            from(t in Team,
              inner_join: u in User,
              as: :user,
              on: u.team_id == t.id,
              where: t.id == ^team_id,
              preload: [users: u]
            )
          )

        render(conn, "show.json", team: team)
      end
    rescue
      _e in Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> render("failure.json", message: "Team or user not found")
    end
  end

  def show(conn, %{"team_id" => id}) do
    query =
      from(t in Team,
        inner_join: u in User,
        on: u.team_id == t.id,
        where: t.id == ^id,
        preload: [users: u]
      )

    team = Repo.one(query)
    render(conn, "team.json", team: team)
  end

  def show_by_manager(conn, %{"manager_id" => manager_id}) do
    IO.inspect(manager_id)

    query =
      from(t in Team,
        inner_join: u in User,
        on: u.team_id == t.id,
        where: t.manager == ^manager_id,
        preload: [users: u]
      )

    team = Repo.one(query)

    if team == nil do
      conn
      |> put_status(:not_found)
      |> render("failure.json", message: "Team not found")
    else
      render(conn, "team.json", team: team)
    end
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team =
      Repo.one(
        from(t in Team,
          inner_join: u in User,
          as: :user,
          on: u.team_id == t.id,
          where: t.id == ^id,
          preload: [users: u]
        )
      )

    with {:ok, %Team{} = team} <- Api.update_team(team, team_params) do
      render(conn, "team.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Api.get_team!(id)

    with {:ok, %Team{}} <- Api.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
