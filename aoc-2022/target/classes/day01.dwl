%dw 2.0
output application/json

var splitByEmptyLines = payload splitBy '\n\n'
var splitByNewLine = splitByEmptyLines map (values) -> (values splitBy '\n') map $ as Number
var totalsPerElf = (splitByNewLine) map (totals) -> sum(totals)
var sortDescendingTotals = totalsPerElf orderBy -$
---
//((splitByNewLine) map (totals) -> sum(totals)) orderBy -$

{
    part1: max(totalsPerElf),
    part2: sortDescendingTotals[0] + sortDescendingTotals[1] + sortDescendingTotals[2]
}
