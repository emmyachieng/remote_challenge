defmodule RemoteChallengeWeb.PageController do
  use RemoteChallengeWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    with list <- RemoteChallenge.Genstate.query_users() do
      render(conn, :home, list: list, layout: false)
    end   
  end
end
