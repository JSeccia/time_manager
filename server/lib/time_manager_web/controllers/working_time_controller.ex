defmodule TimeManagerWeb.WorkingTimeController do
  import Ecto.Query
  use TimeManagerWeb, :controller

  alias TimeManager.Repo
  alias TimeManager.Api
  alias TimeManager.Api.WorkingTime
  alias TimeManager.Api.User

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"user_id" => user_id, "start" => start, "end" => end_} = _params) do
    working_times =
      Repo.all(
        from(w in WorkingTime,
          where: w.start >= ^start and w.end <= ^end_ and w.user_id == ^user_id
        )
      )

    render(conn, "index.json", working_times: working_times)
  end

  def index(conn, %{"user_id" => user_id} = _params) do
    working_times = Repo.all(from(w in WorkingTime, where: w.user_id == ^user_id))
    render(conn, "index.json", working_times: working_times)
  end

  def create_by_id(conn, %{"user_id" => user_id, "working_time" => working_time_params}) do
    working_time_params = Map.put(working_time_params, "user", user_id)

    with {:ok, %WorkingTime{} = working_time} <- Api.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :create_by_id, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def get_one(conn, %{"user_id" => user_id, "id" => id}) do
    working_time = Repo.one(from(w in WorkingTime, where: w.user_id == ^user_id and w.id == ^id))
    render(conn, "show.json", working_time: working_time)
  end

  def show(conn, %{"id" => id}) do
    working_time = Api.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Api.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           Api.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Api.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Api.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
