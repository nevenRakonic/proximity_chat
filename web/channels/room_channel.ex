defmodule ProximityChat.RoomChannel do
  use Phoenix.Channel
  alias ProximityChat.User, as: User

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    IO.puts "joined new channel"
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    IO.puts "new message triggered"
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_in("dispatch", _, socket) do
    user_id = User.generate_random_id
    broadcast! socket, "dispatch", %{user_id: user_id}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

  def handle_out("exit_msg", payload, socket) do
    push socket, "exit_msg", payload
    {:noreply, socket}
  end

  def handle_out("dispatch", payload, socket) do
    push socket, "dispatch", payload
    {:noreply, socket}
  end

  # def terminate({:shutdown, _}, socket) do
  #   broadcast! socket, "exit_msg", %{body: "User left the channel"}
  #   {:noreply, socket}
  # end
end
