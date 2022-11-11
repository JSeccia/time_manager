defmodule TimeManagerWeb.UserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.UserView
  alias TimeManagerWeb.WorkingTimeView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      team_id:
        if(Map.has_key?(user, :team_id),
          do: user.team_id,
          else: nil
        ),
        role: user.role,
      }
  end

  def render("users_working_times.json", %{users: users}) do
    %{
      data: render_many(users, UserView, "user_working_times.json")
    }
  end

  def render("user_working_times.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      working_times: render_many(user.working_times, WorkingTimeView, "working_time.json")
    }
  end

  def render("success.json", %{
        message: message,
        token: token,
        id: id,
        username: username,
        email: email,
        role: role
      }) do
    %{
      ok: true,
      status: 200,
      message: message,
      token: token,
      id: id,
      username: username,
      email: email,
      role: role
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
