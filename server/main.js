const express = require('express')
const fs = require("fs")
const cors = require('cors')

const app = express()

app.use(cors())

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.get("/", (req, res) => {
    var leaderboard = JSON.parse(fs.readFileSync("leaderboard.json").toString())
    res.send(JSON.stringify(leaderboard))
})

app.get("/add", (req, res) => {
    var leaderboard = JSON.parse(fs.readFileSync("leaderboard.json").toString())
    leaderboard.push({
        name: req.query.name,
        score: req.query.score,
        level: req.query.level
    })
    leaderboard.sort((a, b) => (a.score < b.score) ? 1 : -1)
    fs.writeFileSync("leaderboard.json", JSON.stringify(leaderboard))
    res.send(JSON.stringify(leaderboard))
})

app.listen(5000)