%dw 2.0
output application/json

var elfInventory = payload splitBy '\n\n'
var blah = elfInventory map ($ splitBy '\n')

---
max((blah map (arrays) -> arrays map $ as Number) map (totals) -> sum(totals))
