fs = require('fs')
f_context = require('f_context')

##############################################################################

helpers = 

    reverse: (x) -> x.split('').reverse().join('')
    
    words: (str) -> 
        str
            .split (/[^\w]/)
            .filter (x) -> Boolean x.trim()

##############################################################################

analyze = (words) ->
    res = {}
    prev = null
    
    words.forEach (curr) ->
        
        if !res[curr]
            res[curr] = {}
        
        if prev
            if !res[prev][curr] 
                res[prev][curr] = 1
            else
                res[prev][curr]++
                
        prev = curr
        
    return res

##############################################################################

fitness = (x, y) ->
    x = helpers.reverse x
    y = helpers.reverse y
    n = Math.min x.length, y.length
    res = 0
    for i in [0...n]
        if x[i] == y[i] then res++
        else break
    return res
        
##############################################################################

module.exports = {
    analyze,
    helpers,
    fitness
}