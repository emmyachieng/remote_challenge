defmodule RemoteChallenge.User do
  use Ecto.Schema

  schema "users" do
    field :points, :integer, default: 0

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> Ecto.Changeset.cast(attrs, [:points])
    |> Ecto.Changeset.validate_required([:points])
  end
end