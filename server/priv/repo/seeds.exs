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
  team: 1
})

Repo.insert!(%User{
  id: 4,
  username: "user2",
  email: "user2@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team: 1
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
  team: 2
})

Repo.insert!(%User{
  id: 7,
  username: "user4",
  email: "user4@test.fr",
  role: "user",
  password_hash: Bcrypt.hash_pwd_salt("test"),
  team: 2
})

Repo.query("ALTER SEQUENCE users_id_seq RESTART WITH 8")
Repo.query("ALTER SEQUENCE teams_id_seq RESTART WITH 3")
