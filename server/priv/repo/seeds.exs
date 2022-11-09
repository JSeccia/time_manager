# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManager.Repo.insert!(%TimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TimeManager.Repo
alias TimeManager.Api.User
alias TimeManager.Api.Team
alias TimeManager.Api.WorkingTime

use Timex

# Create a user

Repo.insert!(%User{
  id: 1,
  username: "admin",
  email: "admin@test.fr",
  role: "admin",
  password_hash: Bcrypt.hash_pwd_salt("test")
})

Repo.insert!(%User{
  id: 2,
  username: "manager1",
  email: "manager1@test.fr",
  role: "manager",
  password_hash: Bcrypt.hash_pwd_salt("test")
})

Repo.insert!(%Team{
  id: 1,
  manager: 2
})

Repo.insert!(%User{
  id: 3,
  username: "user1",
  email: "user1@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team_id: 1
})

Repo.insert!(%User{
  id: 4,
  username: "user2",
  email: "user2@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team_id: 1
})

Repo.insert!(%User{
  id: 5,
  username: "manager2",
  email: "manager2@test.fr",
  role: "manager",
  password_hash: Bcrypt.hash_pwd_salt("test")
})

Repo.insert!(%Team{
  id: 2,
  manager: 5
})

Repo.insert!(%User{
  id: 6,
  username: "user3",
  email: "user3@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team_id: 2
})

Repo.insert!(%User{
  id: 7,
  username: "user4",
  email: "user4@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team_id: 2
})

IO.inspect(to_string(Timex.today()) <> " 08:00:00")
IO.inspect(NaiveDateTime.truncate(Timex.to_naive_datetime(DateTime.utc_now()), :second))
IO.inspect(NaiveDateTime.new!(Timex.today(), ~T[08:00:00]))
# IO.inspect(Timex.Date.today())

Repo.insert!(%WorkingTime{
  id: 1,
  user_id: 3,
  start: NaiveDateTime.new!(Timex.today(), ~T[08:00:00]),
  end: NaiveDateTime.new!(Timex.today(), ~T[12:00:00])
})

Repo.insert!(%WorkingTime{
  id: 2,
  user_id: 3,
  start: NaiveDateTime.new!(Timex.today(), ~T[14:00:00]),
  end: NaiveDateTime.new!(Timex.today(), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 3,
  user_id: 4,
  start: NaiveDateTime.new!(Timex.beginning_of_week(Timex.today()), ~T[08:00:00]),
  end: NaiveDateTime.new!(Timex.beginning_of_week(Timex.today()), ~T[12:00:00])
})

Repo.insert!(%WorkingTime{
  id: 4,
  user_id: 4,
  start: NaiveDateTime.new!(Timex.beginning_of_week(Timex.today()), ~T[14:00:00]),
  end: NaiveDateTime.new!(Timex.beginning_of_week(Timex.today()), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 5,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[08:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[12:00:00])
})

Repo.insert!(%WorkingTime{
  id: 6,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[14:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 7,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[08:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[12:00:00])
})

Repo.insert!(%WorkingTime{
  id: 8,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[14:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 9,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[08:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[12:00:00])
})

Repo.insert!(%WorkingTime{
  id: 10,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[14:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 11,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[08:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[12:00:00])
})

Repo.insert!(%WorkingTime{
  id: 12,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[14:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[18:00:00])
})

Repo.query("ALTER SEQUENCE users_id_seq RESTART WITH 8")
Repo.query("ALTER SEQUENCE teams_id_seq RESTART WITH 3")
Repo.query("ALTER SEQUENCE working_times_id_seq RESTART WITH 13")

# def get_next_week_day(dow) do
#   Timex.today()
#   |> Timex.shift(days: 7)
#   |> Timex.beginning_of_week(:mon)
#   |> Timex.shift(days: dow)
# end
