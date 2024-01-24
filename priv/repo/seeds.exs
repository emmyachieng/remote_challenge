# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RemoteChallenge.Repo.insert!(%RemoteChallenge.SomeSchema{})

changeset = %RemoteChallenge.User{points: 0}

Enum.each(1..10, fn _ -> RemoteChallenge.Repo.insert!(changeset) end)

#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
