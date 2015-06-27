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
console.log(chan)

$chatInput.on("keypress", event => {
  if(event.keyCode === 13){
    chan.push("new_msg", {body: $chatInput.val()})
    $chatInput.val("")
  }
})

chan.on("new_msg", payload => {
  $messagesContainer.append(`<br/>[${Date()}] ${payload.body}`)
})

chan.on("exit_msg", payload => {
  console.log(payload.body)
})

chan.join().receive("ok", chan => {
  console.log("Welcome to Phoenix Chat!")
})
