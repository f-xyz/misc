fs = require('fs')
min = Math.min

loadFile = (path, cb) ->
    fs.readFile path, (err, content) ->
        if err then throw new Error(err)
        cb content.toString()
        
splitWords = (str) ->
    str
       .split (/[^\w]/)
       .filter (x) -> Boolean x.trim()

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
    
reverse = (x) -> x.split('').reverse().join('')

fitness = (x, y) ->
    x = reverse(x)
    y = reverse(y)
    n = min(x.length, y.length)
    res = 0
    for i in [0..n]
        if x[i] == y[i] then res++
        else break
    return res
        
makeFitnessGraph = (chain) ->
    {}
        
compileChain = (chain) ->
    console.log chain
    for { word, followed } in chain
        console.log 123
    'a b'

module.exports = {
    loadFile, 
    splitWords, 
    analyze,
    reverse,
    fitness,
    makeFitnessGraph,
    compileChain 
}