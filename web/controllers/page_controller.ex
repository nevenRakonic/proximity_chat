defmodule ProximityChat.PageController do
  use ProximityChat.Web, :controller
  alias ProximityChat.User, as: User

  plug :action

  def index(conn, _params) do
    User.push
    conn = put_session(conn, :user_id, User.generate_random_id)
    render conn, "index.html"
  end

  def test(conn, _params) do
    redis_get = User.get_all
    user_id = get_session(conn, :user_id)
    render conn, "test.html", user_id: user_id, redis_get: redis_get
  end
end
