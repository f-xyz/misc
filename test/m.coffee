should = require('chai').should()
m = require('../m')

describe 'words', ->
    it 'should split words and skip everything else', ->
        m.helpers.words('a, b-$c!').should.eql ['a', 'b', 'c']

describe 'analyze', ->
    it 'should build markov chain', () ->
        words = ['a', 'b', 'c', 'a', 'b', 'a', 'c']
        chain = m.analyze words
        chain.should.eql
            a: { b: 2, c: 1 }
            b: { c: 1, a: 1 }
            c: { a: 1 }

describe 'helpers', ->
    it 'reverse string', -> m.helpers.reverse('123').should.eq '321'
    

describe 'fitness', ->
    it 'should calc string similarity', ->
        m.fitness('a', 'b').should.eq 0
        m.fitness('aa', 'ba').should.eq 1
        m.fitness('aac', 'bac').should.eq 2
        m.fitness('c', 'bac').should.eq 1
        
describe 'integration', ->
    it '', ->
        words = ['a', 'b', 'c']
        chain = m.analyze words
        console.dir chain
