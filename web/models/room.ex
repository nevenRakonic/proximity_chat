defmodule ProximityChat.Room do
  import ProximityChat.RedisHelper

  def create_room(room_id, user_id) do
    redis_query ["SADD", "rooms:" <> room_id, user_id]
  end

  def delete_room(room_id) do
    redis_query ["DEL", "rooms:" <> room_id ]
  end

  def remove_user_from_room(room_id, user_id) do
    redis_query ["SREM", "rooms:" <> room_id, user_id]
  end

  def room_size(room_id) do
    redis_query ["SCARD", "rooms:" <> room_id ]
  end

  def rooms do
    # separate list that tracks the existence of rooms
  end

  def last_room do
    # latest room, should be checked and if full (e.g room size > 1) new room
    # should be created
  end


end
