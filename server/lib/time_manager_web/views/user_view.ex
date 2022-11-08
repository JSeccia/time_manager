defmodule TimeManagerWeb.UserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.UserView

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
      team:
        if(Map.has_key?(user, :team),
          do: user.team,
          else: nil
        )
    }
  end

  # def render("internal_user.json", %{user: user}) do
  #   %{
  #     id: user.id,
  #     username: user.username,
  #     email: user.email,
  #     password: user.password_hash
  #     team:
  #       if(Map.has_key?(user, :team),
  #         do: user.team,
  #         else: nil
  #       )
  #   }
  # end

  def render("success.json", %{message: message, token: token}) do
    %{
      ok: true,
      status: 200,
      message: message,
      token: token
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
