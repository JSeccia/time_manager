defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
  end

  pipeline :team_manager do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.TeamManager)
  end

  pipeline :user_manager do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.UserManager)
  end

  pipeline :user_id_auth do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.UserIdAuth)
  end

  pipeline :working_time_id_auth do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.WorkingTimeIdAuth)
  end

  pipeline :clock_id_auth do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.ClockIdAuth)
  end

  pipeline :manager do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.Manager)
  end

  pipeline :clock_auth do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Auth)
    plug(TimeManager.Plug.ClockAuth)
  end

  pipeline :admin do
    plug(:accepts, ["json"])
    plug(TimeManager.Plug.Admin)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :auth])
    resources("/users", UserController)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :auth, :clock_auth])
    post("/clocks/:username", ClockController, :create_by_username)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :team_manager])
    get("/teams/:team_id", TeamController, :show)
    get("/working_times/teams/:team_id", UserController, :wt_by_team)
    get("/clocks/teams/:team_id", UserController, :clocks_by_team)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :user_id_auth])
    get("/working_times/:user_id", WorkingTimeController, :index)
    get("/working_times/:user_id/:id", WorkingTimeController, :get_one)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :user_manager])
    post("/working_times/:user_id", WorkingTimeController, :create_by_id)
    get("/clocks/:user_id", ClockController, :index)
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :working_time_id_auth])
    resources("/working_times", WorkingTimeController, only: [:update, :delete])
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :clock_id_auth])
    resources("/clocks", ClockController, only: [:update, :delete])
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api, :auth, :admin])
    get("/working_times", WorkingTimeController, :get_all_working_times)
    post("/teams/:team_id/users/:user_id", TeamController, :add_user)
    resources("/teams", TeamController, only: [:create, :update, :index, :delete])
  end

  scope "/api", TimeManagerWeb do
    pipe_through([:api])
    resources("/working_times", WorkingTimeController, only: [:update, :delete])
    resources("/clocks", ClockController, only: [:update, :delete])
    resources("/teams", TeamController, only: [:index])
    post("/users/login", UserController, :login)
    get("/teams/manager/:manager_id", TeamController, :show_by_manager)
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
