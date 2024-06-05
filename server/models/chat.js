const mongoose = require('mongoose');

const chatSchema = new mongoose.Schema({
  message: {
    type: String,
    required: true
  },
  sentAt: {
    type: Date,
    default: Date.now
  },
  // userid
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  }

});

const Chat = mongoose.model('Chat', chatSchema);
module.exports = Chat;
