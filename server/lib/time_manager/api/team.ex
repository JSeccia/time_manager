defmodule TimeManager.Api.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    belongs_to(:team_manager, TimeManager.Api.User, foreign_key: :manager, references: :id)
    has_many(:users, TimeManager.Api.User, foreign_key: :team_id, references: :id)

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:manager])
    |> cast_assoc(:manager)
    |> cast_assoc(:users)
  end
end
