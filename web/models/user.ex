defmodule ProximityChat.User do
  use Exredis

  def get_all, do: _redis_query ["LRANGE", "User" | ["0", "-1"] ]
  def push, do: _redis_query ["RPUSH", "User", generate_random_id]

  def remove(user_id) do
     _redis_query ["LREM", "User" | ["-1", user_id]]
  end

  def _redis_query(args), do: start |> query args

  def generate_random_id do
    UUID.uuid1()
  end
end
