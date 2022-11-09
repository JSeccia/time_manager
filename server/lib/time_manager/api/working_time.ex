defmodule TimeManager.Api.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field(:end, :naive_datetime)
    field(:start, :naive_datetime)
    belongs_to(:user, TimeManager.Api.User, foreign_key: :user_id, references: :id)

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
  end
end
