defmodule TimeManager.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.Api.User

  require Logger

  @doc """
  Returns the list of users.
  
  ## Examples
  
      iex> list_users()
      [%User{}, ...]
  
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  
  Raises `Ecto.NoResultsError` if the User does not exist.
  
  ## Examples
  
      iex> get_user!(123)
      %User{}
  
      iex> get_user!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.
  
  ## Examples
  
      iex> create_user(%{field: value})
      {:ok, %User{}}
  
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  
  ## Examples
  
      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}
  
      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset_update(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  
  ## Examples
  
      iex> delete_user(user)
      {:ok, %User{}}
  
      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def update_user_team(%User{} = user, attrs) do
    user
    |> User.changeset_team(attrs)
    |> Repo.update()
  end

  def is_user_admin?(%User{} = user) do
    Logger.info(user)
    user.role == "admin"
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  
  ## Examples
  
      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}
  
  """
  def change_user_password(%User{} = user, attrs \\ %{}) do
    User.changeset_password(user, attrs)
  end

  alias TimeManager.Api.WorkingTime

  @doc """
  Returns the list of working_times.
  
  ## Examples
  
      iex> list_working_times()
      [%WorkingTime{}, ...]
  
  """
  def list_working_times do
    Repo.all(WorkingTime)
  end

  @doc """
  Gets a single working_time.
  
  Raises `Ecto.NoResultsError` if the Working time does not exist.
  
  ## Examples
  
      iex> get_working_time!(123)
      %WorkingTime{}
  
      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  @doc """
  Creates a working_time.
  
  ## Examples
  
      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}
  
      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.
  
  ## Examples
  
      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}
  
      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.
  
  ## Examples
  
      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}
  
      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.
  
  ## Examples
  
      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}
  
  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end

  alias TimeManager.Api.Clock

  @doc """
  Returns the list of clocks.
  
  ## Examples
  
      iex> list_clocks()
      [%Clock{}, ...]
  
  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.
  
  Raises `Ecto.NoResultsError` if the Clock does not exist.
  
  ## Examples
  
      iex> get_clock!(123)
      %Clock{}
  
      iex> get_clock!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Creates a clock.
  
  ## Examples
  
      iex> create_clock(%{field: value})
      {:ok, %Clock{}}
  
      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.
  
  ## Examples
  
      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}
  
      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.
  
  ## Examples
  
      iex> delete_clock(clock)
      {:ok, %Clock{}}
  
      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.
  
  ## Examples
  
      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}
  
  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  alias TimeManager.Api.Team

  @doc """
  Returns the list of teams.
  
  ## Examples
  
      iex> list_teams()
      [%Team{}, ...]
  
  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.
  
  Raises `Ecto.NoResultsError` if the Team does not exist.
  
  ## Examples
  
      iex> get_team!(123)
      %Team{}
  
      iex> get_team!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.
  
  ## Examples
  
      iex> create_team(%{field: value})
      {:ok, %Team{}}
  
      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.
  
  ## Examples
  
      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}
  
      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.
  
  ## Examples
  
      iex> delete_team(team)
      {:ok, %Team{}}
  
      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.
  
  ## Examples
  
      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}
  
  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end
end
