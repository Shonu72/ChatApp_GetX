const mongoose = require('mongoose');

const userSchema = mongoose.Schema({  
    email: {
        type: String,
        required: true,
        validate:{
            validator: (value)=>{
                const re =   /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return re.test(value);
            },
            message: "Please enter a valid email"
        }
    },
    password: {
        type: String,
        required: true
    },
   
  });


const User = mongoose.model('User', userSchema);
module.exports = User; // Export the model