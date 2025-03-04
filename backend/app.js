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
  frequency: String, //day by default. implementation for month/year/custom freq another time.
  title: String,
  type: String, //count/frequency, implement the segregation another time
  description: String,
  count: Int32,
  tracking: Array, //empty array by default.
  habitId: Int32,
  state: String,
  duration: Int32,
  currCount: Int32
}

const Habit = mongoose.model("habit", habitSchema);

app.post('/login', function (req, res) {
  //let log_string = "Attempting login with username " + req.body.username + " and password " + req.body.password

  User.findOne({ username: req.body.username })
    .then(function (user) {
      if (user.password == req.body.password) {
        //console.log(log_string + ". Password correct. ")
        res.sendStatus(200)
      } else {
        //console.log(log_string + ". Password incorrect.")
        res.sendStatus(401)
      }
    })
    .catch(function (err) {
      //console.log(log_string + ". User does not have an account")
      res.sendStatus(404)
    })
})

app.post('/signup', function (req, res) {
  //let log_string = "Attempting signup with username " + req.body.username + " and password " + req.body.password
  //console.log(log_string)

  User.findOne({ username: req.body.username })
    .then(function (user) {
      if(user == null) {
        console.log("Username available!")
        User.create([ {username: req.body.username, password: req.body.password} ])
          .then(res.sendStatus(201))
          .catch(res.sendStatus(404)) //some issue with mongodb i guess
        //console.log("An account has been created. \n")
        
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
      res.send(habits);
    })
    .catch(function(err) {
      //console.log(err);
      res.status(404);
      res.send("An error has occurred")
    })
})

app.put('/habitState', function(req, res) {
  console.log(req.body);

  Habit.findOneAndUpdate({ username: req.body.habit.username, title: req.body.habit.title }, { state: req.body.type })
    .then(function(habit){
      //console.log(habit);
      res.sendStatus(200);
    })
    .catch(function(err){
      console.log(err);
      res.sendStatus(404);
    })
})

app.delete('/habit', function(req,res) {
  console.log(req.body);
  Habit.findOneAndDelete({ username: req.body.habit.username, title: req.body.habit.title})
    .then(function(item) {
      console.log("item deleted")
      res.sendStatus(200)
    })
    .catch(function(err) {
      console.log(err)
      res.sendStatus(400)
    })
})

app.post('/new', function(req, res) {
  //console.log(req.body);
  
  Habit.create({
    username: req.body.username,
    dateAdded: req.body.dateAdded, 
    frequency: "day",
    title: req.body.title,
    type: "count", //count/frequency, implement the segregation another time
    description: req.body.description,
    count: req.body.count,
    duration: req.body.minutes,
    tracking: [], //empty array by default.
    habitId: 1,
    state: 'active',
    currCount: 0
  })
    .then(function(habit) {
      console.log(habit)
      res.sendStatus(200)
    })
    .catch(function(err) {
      console.log(err)
      res.sendStatus(404)
    })
})

app.put('/habit', function(req, res) { //changing habit count
  //console.log(req.body);

  Habit.findOneAndUpdate({ title: req.body.habit.title, username: req.body.habit.username }, { currCount: req.body.habit.currCount })
    .then(function(habit){
      //console.log(habit);
      res.sendStatus(200);
    })
    .catch(function(err){
      console.log(err);
      res.sendStatus(404);
    })
})

app.post('/habitComplete', function(req, res) { //marking as completed, add date
  //console.log(req.body);

  Habit.findOneAndUpdate(
    { title: req.body.habit.title, 
      username: req.body.habit.username 
    }, 
    { $push: { tracking: req.body.date }, currCount: 0 }
  )
    .then(function(item){
      //console.log(item)
      res.sendStatus(200)
    })
    .catch(function(err) {
      console.log(err)
      res.sendStatus(404)
    })
})

app.listen(3000, function () {
  console.log("server is running on port 3000");
})