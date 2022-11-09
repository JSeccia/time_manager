defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
  end

  pipeline :admin do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Admin)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :auth])
    resources("/teams", TeamController, only: [:update, :index, :show])
    post("/teams/:team_id/users/:user_id", TeamController, :add_user)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :admin, :auth])
    resources("/teams", TeamController, only: [:create])
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api])

    resources("/users", UserController)
    resources("/working_times", WorkingTimeController, only: [:update, :delete])
    resources("/clocks", ClockController, only: [:update, :delete])

    post("/users/login", UserController, :login)
    get("/working_times/:user_id/:id", WorkingTimeController, :get_one)
    get("/working_times/:user_id", WorkingTimeController, :index)
    post("/working_times/:user_id", WorkingTimeController, :create_by_id)
    get("/clocks/:user_id", ClockController, :index)
    post("/clocks/:username", ClockController, :create_by_id)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: TimeManagerWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
