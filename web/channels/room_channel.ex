defmodule HelloPhoenix.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

  def terminate({:shutdown, _}, socket) do
    broadcast! socket, "exit_msg", %{body: "User left the channel"}
    {:noreply, socket}
  end

  def handle_out("exit_msg", payload, socket) do
    push socket, "exit_msg", payload
    {:noreply, socket}
  end


end
