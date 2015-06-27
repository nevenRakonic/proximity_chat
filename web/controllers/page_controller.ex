defmodule ProximityChat.PageController do
  use ProximityChat.Web, :controller

  plug :action

  def index(conn, _params) do
    conn = put_session(conn, :user_id, user_id)
    render conn, "index.html"
  end
end
