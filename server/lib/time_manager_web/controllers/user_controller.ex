defmodule TimeManagerWeb.UserController do
  import Ecto.Query

  use TimeManagerWeb, :controller

  alias TimeManager.Repo
  alias TimeManager.Api
  alias TimeManager.Api.User
  alias TimeManager.Api.WorkingTime

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"email" => email, "username" => username} = _params) do
    user = Repo.one(from(u in User, where: u.email == ^email and u.username == ^username))
    render(conn, "show.json", user: user)
  end

  def index(conn, %{"username" => username} = _params) do
    user = Repo.one(from(u in User, where: u.username == ^username))
    render(conn, "show.json", user: user)
  end

  def wt_by_team(conn, %{"team_id" => team_id, "start" => start, "end" => end_}) do
    users =
      Repo.all(
        from(u in User,
          join: w in WorkingTime,
          on: w.user_id == u.id,
          where: u.team_id == ^team_id and w.start >= ^start and w.end <= ^end_,
          preload: [working_times: w]
        )
      )

    render(conn, "users_working_times.json", users: users)
  end

  def wt_by_team(conn, %{"team_id" => team_id}) do
    users =
      Repo.all(
        from(u in User,
          join: w in WorkingTime,
          on: w.user_id == u.id,
          where: u.team_id == ^team_id,
          preload: [working_times: w]
        )
      )

    render(conn, "users_working_times.json", users: users)
  end

  def index(conn, %{"email" => email} = _params) do
    user = Repo.one(from(u in User, where: u.email == ^email))
    render(conn, "show.json", user: user)
  end

  def index(conn, _params) do
    users = Api.list_users()
    render(conn, "index.json", users: users)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    user = Repo.one(from(u in User, where: u.email == ^email))

    if !user || !Bcrypt.verify_pass(password, user.password_hash) do
      render(conn, "failure.json", message: "Wrong email or password")
    else
      token = TimeManager.Token.generate_and_sign!(%{"user_id" => user.id})

      render(conn, "success.json", %{
        message: "ok",
        token: token,
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role
      })
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Api.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Api.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Api.get_user!(id)

    with {:ok, %User{} = user} <- Api.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def update_password(conn, %{"id" => id, "user" => user_params}) do
    user = Api.get_user!(id)

    with {:ok, %User{} = user} <- Api.change_user_password(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Api.get_user!(id)

    with {:ok, %User{}} <- Api.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
