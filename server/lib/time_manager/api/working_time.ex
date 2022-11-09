defmodule TimeManager.Api.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field(:end, :naive_datetime)
    field(:start, :naive_datetime)
    field(:user, :id)

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
  end
end
