defmodule ProximityChat.RedisHelper do
  use Exredis
  def redis_query(args), do: start |> query args
end
