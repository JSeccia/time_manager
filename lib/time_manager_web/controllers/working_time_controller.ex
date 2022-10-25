defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Api
  alias TimeManager.Api.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    working_times = Api.list_working_times()
    render(conn, "index.json", working_times: working_times)
  end

  def create_by_id(conn, %{"user_id" => user_id, "working_time" => working_time_params}) do
    working_time_params = Map.put(working_time_params, "user", user_id)
    with {:ok, %WorkingTime{} = working_time} <- Api.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = Api.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Api.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- Api.update_working_time(working_time, working_time_params) do
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
