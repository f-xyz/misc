module = require('f_context')
should = require('chai').should()

f = module ->

    fact(0) -> 1
    fact(x) -> x * fact x - 1
    
    qsort([]) -> []
    qsort([median, rest...]) -> [
        qsort(x for x in rest when x < median)...,
        median,
        qsort(x for x in rest when x >= median)...
    ]    

describe '#$%', ->

    it 'factorial', ->
        f.fact(0).should.eq 1
        f.fact(1).should.eq 1
        f.fact(2).should.eq 2
        f.fact(3).should.eq 6
        
    it 'quicksort', -> 
        f.qsort([4, 3, 1, 2, 5]).should.eql [1, 2, 3, 4, 5]
        f.qsort([3, 1, 2]).should.eql [1, 2, 3]