import {Socket} from "phoenix"

let socket = new Socket("/ws")
socket.connect()
let chan = socket.chan("private:test", {})
console.log(chan)
chan.join().receive("ok", chan => {
  console.log("Welcome to the secret room :o")
})
