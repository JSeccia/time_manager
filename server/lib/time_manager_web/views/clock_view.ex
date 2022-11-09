defmodule TimeManagerWeb.ClockView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.ClockView
  alias TimeManagerWeb.WorkingTimeView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("working_time.json", %{working_time: working_time}) do
    %{
      id: working_time.id,
      start: working_time.start,
      end: working_time.end,
      user: working_time.user
    }
  end

  def render("clock.json", %{clock: clock}) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status,
      user: clock.user
    }
  end
end
