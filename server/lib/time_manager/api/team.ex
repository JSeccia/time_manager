defmodule TimeManager.Api.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field(:manager, :id)

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:manager])
    |> validate_required([:manager])
  end
end
