defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:manager, references(:users, on_delete: :nothing), null: false)

      timestamps()
    end

    create(index(:teams, [:manager]))
  end
end
