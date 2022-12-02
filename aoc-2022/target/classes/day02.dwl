%dw 2.0
output application/json

var parsedData = ((payload splitBy  "\n") map (value) -> value splitBy " ")

var opponentMoveOptions = {
    A: "Rock",
    B: "Paper",
    C: "Scissors"
}
var myMoveOptions = {
    X: "Rock",
    Y: "Paper",
    Z: "Scissors"
}

var shapeValues = {
    "Rock": 1,
    "Paper": 2,
    "Scissors": 3
}

var scores = {
    "Win": 6,
    "Lose": 0,
    "Draw": 3
}

var winConditions = {
    "Rock": "Scissors",
    "Paper": "Rock",
    "Scissors": "Paper"
}

fun findShapeValue(move) = 
    shapeValues[myMoveOptions[move]]
    
fun fight(opponent, mine) =
    if (mine == opponent)
        "Draw"
    else if (winConditions[opponent] == mine)
        "Lose"
    else "Win"

fun findRoundScore(opponentRaw, mineRaw) =
    scores[fight(opponentMoveOptions[opponentRaw], myMoveOptions[mineRaw])] + findShapeValue(mineRaw)
---
//findRoundScore(parsedData[0][0], parsedData[0][1])

sum(parsedData map (value) -> findRoundScore(value[0], value[1]))
