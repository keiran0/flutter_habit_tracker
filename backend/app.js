require('dotenv').config();

const express = require('express');
const app = express();
const mongoose = require('mongoose');
const cors = require('cors');
const { MongoClient, ServerApiVersion, Int32 } = require('mongodb');
const uri = process.env.URI
app.use(cors());

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

const client = new MongoClient(uri, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});
async function run() {
  try {
    // Connect the client to the server	(optional starting in v4.7)
    await client.connect();
    // Send a ping to confirm a successful connection
    await client.db("admin").command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
}
run().catch(console.dir);

db = mongoose.connect(uri, {
  dbName: 'habitTracker'
});

const userSchema = {
  username: String,
  password: String,
}

const User = mongoose.model("user", userSchema);

const habitSchema = {
  username: String,
  dateAdded: Date,
  frequency: String,
  title: String,
  type: String,
  description: String,
  count: Int32
}

const Habit = mongoose.model("habit", habitSchema);

app.post('/login', function (req, res) {
  let log_string = "Attempting login with username " + req.body.username + " and password " + req.body.password

  User.findOne({ username: req.body.username })
    .then(function (user) {
      if (user.password == req.body.password) {
        console.log(log_string + ". Password correct. ")
        res.sendStatus(200)
      } else {
        console.log(log_string + ". Password incorrect.")
        res.sendStatus(401)
      }
    })
    .catch(function (err) {
      console.log(log_string + ". User does not have an account")
      res.sendStatus(404)
    })
})

app.post('/signup', function (req, res) {
  let log_string = "Attempting signup with username " + req.body.username + " and password " + req.body.password
  console.log(log_string)

  User.findOne({ username: req.body.username })
    .then(function (user) {
      if(user == null) {
        console.log("Username available!")
        User.create([ {username: req.body.username, password: req.body.password} ])
          .then(res.sendStatus(201))
          .catch(res.sendStatus(404)) //some issue with mongodb i guess
        console.log("An account has been created. \n")
        
      } else {
        console.log("Username not available.")
        res.sendStatus(200)
      }
      
    })
    .catch(function (err) {
      console.log(err)
    })
})

app.get('/habits/:username', function(req, res) {
  console.log("Obtaining habits from " + req.params.username)
  
  Habit.find({ username: req.params.username })
    .then(function(habits){
      res.status(200);
      console.log(habits)
      res.send(habits);
    })
    .catch(function(err) {
      console.log(err);
      res.status(404);
      res.send("An error has occurred")
      
    })
})



app.listen(3000, function () {
  console.log("server is running on port 3000");
})