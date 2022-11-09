defmodule TimeManagerWeb.TeamView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.TeamView
  alias TimeManagerWeb.UserView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      manager: team.manager,
      users: render_many(team.users, UserView, "user.json")
    }
  end

  def render("teams.json", %{teams: teams}) do
    %{
      data: render_many(teams, TeamView, "team.json")
    }
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      team:
        if(Map.has_key?(user, :team),
          do: user.team,
          else: nil
        )
    }
  end

  def render("failure.json", %{message: message}) do
    %{
      ok: false,
      status: 200,
      message: message
    }
  end
end
