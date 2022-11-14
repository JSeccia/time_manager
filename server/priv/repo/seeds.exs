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

Repo.insert!(%User{
  id: 8,
  username: "manager3",
  email: "manager3@test.fr",
  role: "manager",
  password_hash: Bcrypt.hash_pwd_salt("test")
})

Repo.insert!(%Team{
  id: 3,
  manager: 8
})

Repo.insert!(%User{
  id: 9,
  username: "user5",
  email: "user5@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team_id: 2
})

Repo.insert!(%User{
  id: 10,
  username: "user6",
  email: "user6@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team_id: 1
  })

# Create working times

Repo.insert!(%WorkingTime{
  id: 1,
  user_id: 3,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 6), ~T[01:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 6), ~T[05:00:00])
})

Repo.insert!(%WorkingTime{
  id: 2,
  user_id: 3,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 7), ~T[03:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 7), ~T[06:00:00])
})

Repo.insert!(%WorkingTime{
  id: 3,
  user_id: 4,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 6), ~T[08:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 6), ~T[16:00:00])
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
  user_id: 3,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[14:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 13,
  user_id: 9,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[01:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[05:00:00])
})

Repo.insert!(%WorkingTime{
  id: 14,
  user_id: 9,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[14:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[18:00:00])
})

Repo.insert!(%WorkingTime{
  id: 15,
  user_id: 9,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[10:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[15:00:00])
})

Repo.insert!(%WorkingTime{
  id: 16,
  user_id: 9,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[21:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[23:35:00])
})

Repo.insert!(%WorkingTime{
  id: 17,
  user_id: 9,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 5), ~T[17:05:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 5), ~T[22:15:00])
})

Repo.insert!(%WorkingTime{
  id: 18,
  user_id: 10,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[18:05:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 1), ~T[21:15:00])
})

Repo.insert!(%WorkingTime{
  id: 19,
  user_id: 10,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[12:05:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 2), ~T[17:30:00])
})

Repo.insert!(%WorkingTime{
  id: 20,
  user_id: 10,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[06:05:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 3), ~T[12:45:00])
})

Repo.insert!(%WorkingTime{
  id: 21,
  user_id: 10,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[08:00:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 4), ~T[13:10:00])
})

Repo.insert!(%WorkingTime{
  id: 22,
  user_id: 10,
  start: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 5), ~T[16:05:00]),
  end: NaiveDateTime.new!(Date.add(Timex.beginning_of_week(Timex.today()), 5), ~T[20:55:00])
})



Repo.query("ALTER SEQUENCE users_id_seq RESTART WITH 11")
Repo.query("ALTER SEQUENCE teams_id_seq RESTART WITH 4")
Repo.query("ALTER SEQUENCE working_times_id_seq RESTART WITH 23")
