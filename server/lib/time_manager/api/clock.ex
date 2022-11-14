defmodule TimeManager.Api.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field(:status, :boolean, default: false)
    field(:time, :naive_datetime)
    belongs_to(:clock, TimeManager.Api.Team, foreign_key: :user_id, references: :id)

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
  end
end
