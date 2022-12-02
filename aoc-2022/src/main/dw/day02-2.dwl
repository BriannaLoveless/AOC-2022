%dw 2.0
output application/json

var parsedData = ((payload splitBy  "\n") map (value) -> value splitBy " ")

var opponentMoveOptions = {
    A: "Rock",
    B: "Paper",
    C: "Scissors"
}
var desiredResult = {
    X: "Lose",
    Y: "Draw",
    Z: "Win"
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

var loseConditions = winConditions mapObject {($):$$}

fun findShapeValue(move) = 
    shapeValues[move]
    
fun fight(opponent, mine) =
    if (mine == opponent)
        "Draw"
    else if (winConditions[opponent] == mine)
        "Lose"
    else "Win"


fun calcMyMove(opponentMove, result) =
    if (result == "Draw")
        opponentMove
    else if (result == "Lose")
        winConditions[opponentMove]
    else loseConditions[opponentMove]

fun findRoundScore(opponent, result) =
    scores[result] + findShapeValue(calcMyMove(opponent, result))

---
sum(parsedData map (value) -> findRoundScore(opponentMoveOptions[value[0]], desiredResult[value[1]]))
