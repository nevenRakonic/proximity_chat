defmodule ProximityChat.User do
  import ProximityChat.RedisHelper

  def get_all, do: redis_query ["LRANGE", "User" | ["0", "-1"] ]
  def push, do: redis_query ["RPUSH", "User", generate_random_id]

  def remove(user_id) do
    redis_query ["LREM", "User" | ["-1", user_id]]
  end

  def generate_random_id do
    UUID.uuid1()
  end
end
