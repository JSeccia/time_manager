defmodule TimeManager.Plug.Auth do
  import Plug.Conn

  use TimeManagerWeb, :controller
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    # Logger.info("Auth plug called")
    # ["Bearer " <> token] = get_req_header(conn, "authorization")
    # Logger.error(Enum.at(get_req_header(conn, "Authorization"), 0))
    # Logger.warn(token)
    # Logger.error(TimeManager.Token.verify_and_validate(token))

    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- TimeManager.Token.verify_and_validate(token) do
      conn
      |> assign(:current_user, TimeManager.Api.get_user!(data["user_id"]))
    else
      error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end
