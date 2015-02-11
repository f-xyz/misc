should = require('chai').should()
fs     = require('fs')
m      = require('../m')

describe 'loadFile', ->
    _readFile = null
    beforeEach -> _readFile = fs.readFile
    afterEach -> fs.readFile = _readFile
        
    it 'should load file', (done) ->         
        content = '123 321'
        fs.readFile = (path, cb) -> cb null, new Buffer(content)
        
        m.loadFile 'file.txt', (words) ->
            words.should.eq content
            done()
            
    it 'should rethrow', () -> 
        fs.readFile = (path, cb) -> cb '#$%', null
        (-> m.loadFile 'file.txt', ->).should.throw '#$%'

describe 'splitWords', ->
    it 'should split words and skip non-words', ->
        m.splitWords('a, b-$c!').should.eql ['a', 'b', 'c']

describe 'analyze', ->
    it 'should build chain', () ->
        words = ['a', 'b', 'c', 'a', 'b', 'a', 'c']
        chain = m.analyze words
        chain.should.eql
            a: { b: 2, c: 1 }
            b: { c: 1, a: 1 }
            c: { a: 1 }

describe 'reverse', ->
    it 'should reverse string', ->   
        m.reverse('abc').should.eq 'cba'
    
describe 'fitness', ->
    it 'should calc string similarity from end', ->
        m.fitness('a', 'b').should.eq 0
        m.fitness('aa', 'ba').should.eq 1
        m.fitness('aac', 'bac').should.eq 2
        m.fitness('c', 'bac').should.eq 1

describe 'compileChain', ->
    it 'should <you know what>', ->
        words = ['a', 'b']
        chain = m.analyze words
        str = m.compileChain chain
        str.should.eq 'a b'