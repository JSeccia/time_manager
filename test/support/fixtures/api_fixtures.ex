defmodule TimeManager.ApiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Api` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> TimeManager.Api.create_user()

    user
  end
end
