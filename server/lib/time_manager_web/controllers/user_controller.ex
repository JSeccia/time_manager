defmodule TimeManagerWeb.UserController do
  import Ecto.Query
  use TimeManagerWeb, :controller

  alias TimeManager.Repo
  alias TimeManager.Api
  alias TimeManager.Api.User

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"email" => email, "username" => username} = _params) do
    user = Repo.one(from u in User, where: u.email == ^email and u.username == ^username)
    render(conn, "show.json", user: user)
  end

  def index(conn, %{"username" => username} = _params) do
    user = Repo.one(from u in User, where: u.username == ^username)
    render(conn, "show.json", user: user)
  end

  def index(conn, %{"email" => email,} = _params) do
    user = Repo.one(from u in User, where: u.email == ^email)
    render(conn, "show.json", user: user)
  end

  def index(conn, _params) do
    users = Api.list_users()
    render(conn, "index.json", users: users)
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

  def delete(conn, %{"id" => id}) do
    user = Api.get_user!(id)

    with {:ok, %User{}} <- Api.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
