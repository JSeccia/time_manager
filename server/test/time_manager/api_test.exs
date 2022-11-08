defmodule TimeManager.ApiTest do
  use TimeManager.DataCase

  alias TimeManager.Api

  describe "users" do
    alias TimeManager.Api.User

    import TimeManager.ApiFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Api.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Api.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %User{} = user} = Api.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %User{} = user} = Api.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_user(user, @invalid_attrs)
      assert user == Api.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Api.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Api.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Api.change_user(user)
    end
  end

  describe "working_times" do
    alias TimeManager.Api.WorkingTime

    import TimeManager.ApiFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_working_times/0 returns all working_times" do
      working_time = working_time_fixture()
      assert Api.list_working_times() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert Api.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{end: ~N[2022-10-24 08:30:00], start: ~N[2022-10-24 08:30:00]}

      assert {:ok, %WorkingTime{} = working_time} = Api.create_working_time(valid_attrs)
      assert working_time.end == ~N[2022-10-24 08:30:00]
      assert working_time.start == ~N[2022-10-24 08:30:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{end: ~N[2022-10-25 08:30:00], start: ~N[2022-10-25 08:30:00]}

      assert {:ok, %WorkingTime{} = working_time} = Api.update_working_time(working_time, update_attrs)
      assert working_time.end == ~N[2022-10-25 08:30:00]
      assert working_time.start == ~N[2022-10-25 08:30:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_working_time(working_time, @invalid_attrs)
      assert working_time == Api.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = Api.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> Api.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = Api.change_working_time(working_time)
    end
  end

  describe "clocks" do
    alias TimeManager.Api.Clock

    import TimeManager.ApiFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Api.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Api.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2022-10-24 08:40:00]}

      assert {:ok, %Clock{} = clock} = Api.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2022-10-24 08:40:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2022-10-25 08:40:00]}

      assert {:ok, %Clock{} = clock} = Api.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2022-10-25 08:40:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_clock(clock, @invalid_attrs)
      assert clock == Api.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Api.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Api.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Api.change_clock(clock)
    end
  end

  describe "teams" do
    alias TimeManager.Api.Team

    import TimeManager.ApiFixtures

    @invalid_attrs %{}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Api.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Api.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{}

      assert {:ok, %Team{} = team} = Api.create_team(valid_attrs)
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{}

      assert {:ok, %Team{} = team} = Api.update_team(team, update_attrs)
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_team(team, @invalid_attrs)
      assert team == Api.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Api.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Api.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Api.change_team(team)
    end
  end
end
