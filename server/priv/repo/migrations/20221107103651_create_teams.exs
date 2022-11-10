defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:manager, references(:users, on_delete: :nilify_all), null: true)

      timestamps()
    end

    create(index(:teams, [:manager]))
  end
end
