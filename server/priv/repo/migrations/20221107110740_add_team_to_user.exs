defmodule TimeManager.Repo.Migrations.AddTeamToUser do
  use Ecto.Migration

  def change do
    alter table("users") do
      add(:team_id, references(:teams, on_delete: :nilify_all))
    end
  end
end
