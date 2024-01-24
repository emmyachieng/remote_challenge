defmodule RemoteChallenge.Genstate do
  use GenServer

  import Ecto.Query
 
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{max_number: Enum.random(0..100), timestamp: nil }, name: __MODULE__)
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_work()

    {:ok, state}
  end
  
  def query_users() do
    GenServer.call(RemoteChallenge.Genstate, :query)
  end

  @impl true
  def handle_info(:work, state) do
    state =  %{state | max_number: Enum.random(0..100)}

    # Fetch all users
    query = from u in RemoteChallenge.User
    points = RemoteChallenge.Repo.all(query)

    Enum.each(points, fn user ->
      changeset = RemoteChallenge.User.changeset(user, %{points: Enum.random(0..100)})
      RemoteChallenge.Repo.update(changeset)
    end)

    # Reschedule once more
    schedule_work()

    {:noreply, state}
  end

  @impl true
  def handle_call(:query, _from, state) do

    query = from u in RemoteChallenge.User, where: u.points > ^state.max_number, limit: 2
    result = RemoteChallenge.Repo.all(query)

    state = %{state | timestamp: DateTime.now("Etc/UTC")}

    {:reply, result, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, :timer.minutes(1))
  end
end