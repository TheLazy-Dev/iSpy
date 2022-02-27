const { v4: uuidv4 } = require("uuid");
const express = require("express");
var http = require("http");
const app = express();
const port = process.env.port || 3000;
var server = http.createServer(app);
var io = require("socket.io")(server);
let users = {
 
};

app.use(express.json());

io.on("connection", (socket) => {
  console.log("connected");
  socket.emit("handshake", "connected");
  const uuid = uuidv4();
  socket.on("message", (source) => {
    data = JSON.parse(source);
    switch (data["event"]) {
      case "register":
        try {
          users[uuid] = { username: data["username"], connection: socket };
          console.log(uuid);
          socket.emit("loggedin", uuid);
          break;
        } catch (error) {
          console.log(error);
        }
      case "getAll":
        try {
          const usernames = [];
          for (let [key, value] of Object.entries(users)) {
            usernames.push({ id: key, username: value["username"] });
          }
          console.log(usernames);
          socket.emit("allUsers", JSON.stringify(usernames));
          break;
        } catch (error) {
          console.log(error);
        }

      case "send_ispy":
        try {
          receiver_socket = users[data["receiver"]]["connection"];
          receiver_socket.emit("receive_ispy", data["data"]);
        } catch (error) {
          console.log(error);
        }
        break;
      case "response_ispy":
        try {
          sender_socket = users[data["sender"]]["connection"];
          sender_socket.emit("response_ispy", data["data"]);
        } catch (error) {
          console.log(error);
        }
       break;
        case 'verify_ispy':
        try {
          sender_socket = users[data["sender"]]["connection"];
          sender_socket.emit("response_ispy", data["data"]);
        } catch (error) {
          console.log(error);
        }
       break;
       case 'exit':
        try {
          sender_socket = users[data["sender"]]["connection"];
          sender_socket.emit("response_ispy", data["data"]);
        } catch (error) {
          console.log(error);
        }
       break;
      default:
        break;
    }
  });

  socket.on("close", () => {
    delete users[uuid];
  });
});

server.listen(port, () =>
  console.log(`Example app listening on port ${port}!`)
);

/*
 */

/*

{"event":"register","username":"random"}


{"event":"getAll"}
*/
