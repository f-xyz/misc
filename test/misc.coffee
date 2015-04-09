require('chai').should()
transform = require('../validation').transform
camelCase = require('../validation').camelCase

describe 'transform tests', ->

  it 'should be a function', -> transform.should.be.a('function')

  it 'should make a dictionary like property => messages', ->
    data = [{ property: 'name', messages: [] }]
    transform(data).should.eql({ name: [] })

  it 'should make keys camelCased', ->
    data = [{ property: 'Name', messages: [] }]
    transform(data).should.eql({ name: [] })

  it 'should put items with empty property in _common key', ->
    data = [{ property: '', messages: [] }]
    transform(data).should.eql({ _common: [] })

  it 'should combine items messages with the same property', ->
    data = [{ property: 'name', messages: ['qwe'] },
            { property: 'name', messages: ['asd'] }]
    transform(data).should.eql({ name: ['qwe', 'asd'] })

  describe 'camelCase tests', ->
    it 'should be a function', -> camelCase.should.be.a('function')
    it 'should make strings camelCased', -> camelCase('QweAsd').should.eq('qweAsd')
    it 'should make false values empty string', -> camelCase(null).should.eq('')

  describe 'integration tests', ->
    it 'should transform validation messages into dictionary', ->
      data = [{
        property: 'UserName',
        messages: [
          'Name is required.',
          'Name cannot contain swear words.',
          'Name\'s length cannot exceed 1488 characters.'
        ],
      }, {
        property: 'UserAge',
        messages: [
          'Age is required.'
        ],
      }, {
        property: 'UserAge',
        messages: [
          'Age must be positive.'
        ],
      }, {
        property: '',
        messages: [
          'Server error.',
          'Something wrong happened.'
        ],
      }]
      res = transform(data)
      res.should.eql({
        _common: [
          'Server error.',
          'Something wrong happened.'
        ],
        userName: [
          'Name is required.',
          'Name cannot contain swear words.',
          'Name\'s length cannot exceed 1488 characters.'
        ],
        userAge: [
          'Age is required.',
          'Age must be positive.'
        ]
      })