require('chai').should()

flatten = (list) ->
  list.reduce (res, x) ->
    if Array.isArray x then res.concat flatten x
    else                    res.concat [x]
  , []

describe 'flatten() tests', ->

  it 'leaves plain arrays unchanged', ->
    res = flatten [1, 2, 3]
    res.should.eql [1, 2, 3]

  it 'flattens arrays', ->
    res = flatten [1, [2, [3, [4]]], 5]
    res.should.eql [1, 2, 3, 4, 5]
