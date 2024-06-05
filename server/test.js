const io = require('socket.io-client');

const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NWRiYjRlNTVhMDdjYzJlYjE0NmVlMCIsImlhdCI6MTcxNzQ4MzY2Nn0.c1HdyZ-a7IfZSaTgaCPyDZ1bPcOnSdfyfA3QFIFTicI'; 

const socket = io('http://localhost:3000', {
  query: { token }
});

socket.on('connect', () => {
  console.log('Connected to server');

  // Send a message
  socket.emit('message', { message: 'Hello, this is a test message!' });

  // Listen for messages
  socket.on('message', (message) => {
    console.log('New message:', message);
  });
});

socket.on('disconnect', () => {
  console.log('Disconnected from server');
});

socket.on('connect_error', (err) => {
  console.error('Connection error:', err);
});
