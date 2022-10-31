defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, size: 32, null: false
      add :email, :string, size: 128, null: false

      timestamps()
    end
    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
