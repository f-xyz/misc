_ = require('lodash')
fs = require('fs')
should = require('chai').should()
colors = require('colors')

bose = require('../engine')
draw = require('../draw')

describe '', ->
    it '', ->

#      content = fs.readFileSync('data/fox.txt').toString()
      content = fs.readFileSync('data/haiku.txt').toString()
#      content = fs.readFileSync('data/kobzar.txt').toString()

      words = bose.tokenize content
      data = bose.analyze words

      # rhyme finder - make in engine.coffee

#      word = words[~~(Math.random()*words.length)]
#
#      words = _.filter words, (x) -> bose.fitness(x, word) > 0
#      words = _.sortBy words, (x) -> -bose.fitness x, word
#      words = _.unique words
#
#      console.log word
#      words.slice(1, 6).forEach (x) ->
#        console.log '  ', x, bose.fitness(x, word)
#
#      return


      for i in [0...5]
        console.log '# ' + i
        console.log bose.builder(data).build()
        console.log '\n'
