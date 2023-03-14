%dw 2.0
output application/json
import slice, splitAt from dw::core::Arrays

var parsedData = input1 splitBy '\r\n'
var priorityValues =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 
    reduce ((char, obj={}) -> obj ++ { (char): sizeOf(obj)+1 })

fun divideString(str) = str splitBy "" splitAt sizeOf(str)/2

fun findMatch(array1, array2) = array1 filter (item) -> array2 contains item

fun findMatches(rucksacks) = rucksacks map do {
    var compartments = divideString($)
    ---
    findMatch(compartments["l"], compartments["r"])[0]
}
---
sum(findMatches(parsedData) map priorityValues[$])