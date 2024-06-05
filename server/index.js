const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);
const messages = []


io.on('connection', (socket) => {
  const username = socket.handshake.query.username
  const chatID = socket.handshake.query.chatID
  socket.join(chatID)

  socket.on('disconnect', () => {
    socket.leave(chatID)
  })
  // for group chat
  socket.on('message', (data) => {
    const message = {
      message: data.message,
      senderUsername: username,
      sentAt: Date.now()
    }
    messages.push(message)
    io.emit('message', message)
  })

  // })
// one to one chat
  socket.on('send_message', message => {
        receiverChatID = message.receiverChatID
        senderChatID = message.senderChatID
        content = message.content

        //Send message to only that particular room
        socket.in(receiverChatID).emit('receive_message', {
            'content': content,
            'senderChatID': senderChatID,
            'receiverChatID':receiverChatID,
        })
    })
});

server.listen(3000, () => {
  console.log('listening on *:3000');
});














































// const express = require('express');
// const mongoose = require('mongoose');
// const authRouter = require('./routes/auth');
// const cors = require('cors');
// const io = require('./routes/chats');
// const http = require('http');


// const PORT = process.env.PORT || 3000;
// const app = express();
// app.use(cors());

// app.use(express.json());
// app.use(authRouter);

// const DB = "mongodb+srv://developersonu:ptanhikyarakhu@cluster0.o59binf.mongodb.net/";

// mongoose.connect(DB).then(()=>{
//     console.log("DB Connection successful");
// }).catch((err)=>console.log(err));

// const server = http.createServer(app); // Create an HTTP server
// io.attach(server); 

// app.listen(PORT, () => {
//   console.log(`Server is running on port ${PORT}`);
// });