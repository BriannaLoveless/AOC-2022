%dw 2.0
output application/json
import slice, splitAt from dw::core::Arrays
import repeat from dw::core::Strings

var parsedData = input1 splitBy '\r\n'
var priorityValues =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 
    reduce ((char, obj={}) -> obj ++ { (char): sizeOf(obj)+1 })

fun divideString(str) = str splitBy "" splitAt sizeOf(str)/2

fun findMatch(array1, array2, array3) = array1 filter (item) -> (array2 contains item) and (array3 contains item)

fun findMatches(rucksacks) = repeat("0,",sizeOf(rucksacks)/3) splitBy "," map do {
    var compartment1 = parsedData[3*($$)] splitBy ""
    var compartment2 = parsedData[3*($$) + 1] splitBy ""
    var compartment3 = parsedData[3*($$) + 2] splitBy ""
    ---
    findMatch(compartment1, compartment2, compartment3)[0]
}
---
sum(findMatches(parsedData) map priorityValues[$])