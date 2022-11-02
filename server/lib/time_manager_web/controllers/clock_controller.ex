defmodule TimeManagerWeb.ClockController do
  import Ecto.Query
  use Timex
  use TimeManagerWeb, :controller

  alias TimeManager.Repo
  alias TimeManager.Api
  alias TimeManager.Api.Clock
  alias TimeManager.Api.User
  alias TimeManager.Api.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    clocks = Repo.all(from c in Clock, where: c.user == ^user_id)
    render(conn, "index.json", clocks: clocks)
  end

  def create_by_id(conn, %{"username" => username}) do
    user_id = Repo.one(from u in User, where: u.username == ^username).id
    previous_clock = Repo.one(from c in Clock, where: c.user == ^user_id, order_by: [desc: c.id], limit: 1)
    clock_params = %{}
    clock_params = Map.put(clock_params, "status", (if previous_clock != nil, do: !previous_clock.status, else: true))
    clock_params = Map.put(clock_params, "user", user_id)
    clock_params = Map.put(clock_params, "time", Timex.now())
    with {:ok, %Clock{} = clock} <- Api.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :create_by_id, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Api.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Api.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Api.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Api.get_clock!(id)

    with {:ok, %Clock{}} <- Api.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
