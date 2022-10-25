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
end
