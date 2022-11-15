defmodule TimeManager.Plug.UserIdAuth do
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
    user =
      try do
        TimeManager.Api.get_user!(conn.params["user_id"])
      rescue
        e in Ecto.NoResultsError ->
          conn
          |> put_status(:not_found)
          |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
          |> Phoenix.Controller.render(:"404")
          |> halt()
      end

    case conn.assigns.current_user.role do
      "admin" ->
        conn

      "manager" ->
        team = Repo.one(from(t in Team, where: t.manager == ^conn.assigns.current_user.id))

        if team.manager == conn.assigns.current_user.id do
          conn
        else
          conn
          |> put_status(:unauthorized)
          |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
          |> Phoenix.Controller.render(:"401")
          |> halt()
        end

      "user" ->
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
