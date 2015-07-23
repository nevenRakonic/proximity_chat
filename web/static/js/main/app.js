import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

let $chatInput         = $("#chat-input")
let $messagesContainer = $("#messages")

let socket = new Socket("/ws")
socket.connect()
let chan = socket.chan("rooms:lobby", {})

$chatInput.on("keypress", event => {
  if(event.keyCode === 13){
    console.log(chan)
    chan.push("new_msg", {body: $chatInput.val()})
    $chatInput.val("")
  }
})

chan.on("dispatch", payload => {
  chan.leave()
  chan = socket.chan("rooms:" + payload.user_id, {})

  chan.join().receive("ok", sock_chan => {
    $messagesContainer.append(`<br/>You have entered the room: ${payload.user_id}`)
  })

  chan.on("new_msg", payload => {
    $messagesContainer.append(`<br/>[${Date()}] ${payload.body}`)
  })
})


chan.on("exit_msg", payload => {
  $messagesContainer.append(`<br/>[${Date()}] ${payload.body}`)
})

chan.join().receive("ok", sock_chan => {
  chan.push("dispatch", {})
})
