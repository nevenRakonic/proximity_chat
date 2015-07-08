defmodule ProximityChat.Router do
  use ProximityChat.Web, :router

  socket "/ws", HelloPhoenix do
    channel "rooms:*", RoomChannel
    channel "private:test", TestChannel
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ProximityChat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/test", PageController, :test
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProximityChat do
  #   pipe_through :api
  # end
end
