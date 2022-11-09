defmodule TimeManager.Api.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    belongs_to(:user, TimeManager.Api.User, foreign_key: :manager, references: :id)
    has_many(:users, TimeManager.Api.User, foreign_key: :team, references: :id)

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:manager])
    |> cast_assoc(:users)
    |> validate_required([:manager])
  end
end
