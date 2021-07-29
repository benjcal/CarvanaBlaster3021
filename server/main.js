const express = require('express')
const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

var leaderboard = [
    {name: "Ben", score: 100},
    {name: "Bradley", score: 130},
]

app.get("/", (req, res) => {
    leaderboard.sort((a, b) => (a.score < b.score) ? 1 : -1)
    res.send(JSON.stringify(leaderboard))
})

app.put("/", (req, res) => {
    leaderboard.push(req.body)
    leaderboard.sort((a, b) => (a.score < b.score) ? 1 : -1)
    res.send(JSON.stringify(leaderboard))
})

app.listen(5000)