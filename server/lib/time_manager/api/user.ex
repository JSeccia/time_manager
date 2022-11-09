defmodule TimeManager.Api.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    belongs_to(:team, TimeManager.Api.Team, foreign_key: :team_id, references: :id)
    has_many(:working_times, TimeManager.Api.WorkingTime, foreign_key: :user_id, references: :id)
    field(:role, :string)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role, :team_id])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/\S+@\S+\.\S+/)
    |> unique_constraint(:email, message: "mail already taken")
    |> unique_constraint(:username, message: "username already taken")
    |> put_pass_hash()
  end

  def changeset_team(user, attrs) do
    user
    |> cast(attrs, [:team])
    |> cast_assoc(:working_times)
    |> validate_required([:team])
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
