defmodule TimeManager.Plug.ClockAuth do
  import Plug.Conn

  import Ecto.Query
  use TimeManagerWeb, :controller
  require Logger
  alias TimeManager.Api.User
  alias TimeManager.Api.Team
  alias TimeManager.Repo

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = Repo.one(from(u in User, where: u.username == ^conn.params["username"]))

    case conn.assigns.current_user.role do
      "admin" ->
        conn

      "manager" ->
        team = Repo.one(from(t in Team, where: t.manager == ^conn.assigns.current_user.id))

        if team.id == user.team_id do
          conn
        else
          conn
          |> put_status(:unauthorized)
          |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
          |> Phoenix.Controller.render(:"401")
          |> halt()
        end

      "user" ->
        IO.inspect("tototo")

        if conn.assigns.current_user.id == user.id do
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
