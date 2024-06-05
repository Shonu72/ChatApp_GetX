const express = require("express");
const User = require("../models/users");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");


// signup route 
authRouter.post('/api/signup',async (req, res) => {
    try {
       const {email,password} = req.body;
       const existingUser = await User.findOne({email});
         if(existingUser){
              return res.status(400).json({msg:"User already exists"});
         }
          const saltRounds = 10; // we can adjust the salt rounds as per our requirement
        const hashedPassword = await bcryptjs.hash(password, saltRounds);
        
         let user = new User({
            email,
            password: hashedPassword,
         });
         user = await user.save();
         res.json(user);

    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

//signin route
authRouter.post("/api/signin", async (req, res)=>{
try {
    const {email,password} = req.body;
    const user = await User.findOne({email});
    if(!user){
        return res
        .status(400)
        .json({msg:"User does not exist, please register"});
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if(!isMatch){
        return res.status(400).json({msg:"Invalid Password"});
    }
    const token = jwt.sign({id: user._id}, "passwordKey");
    res.json({
        token,
         ...user.doc
    })
    
} catch (error) {
    res.status(500).json({error:error.message,});
}
})



module.exports = authRouter; // Export the router