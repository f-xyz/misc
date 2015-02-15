_ = require('lodash')
fs = require('fs')
should = require('chai').should()
colors = require('colors')

bose = require('../engine')
draw = require('../draw')

describe '', ->
    it '', ->

#      content = 'so adorable cute beautiful amazing fox classy fox red nosy fox red'
      content = 'Як помру то поховайте,
                 В жопу пороху напхайте,
                 Підпаліть і полягайте,
                 Як бабахне - то вставайте,
                 Кісточки пособирийте
                 Ну а потім поховайте.'
#      content = fs.readFileSync('data/fox.txt').toString()
#      content = fs.readFileSync('data/haiku.txt').toString()
#      content = fs.readFileSync('data/kobzar.txt').toString()

      words = bose.tokenize content
      data = bose.analyze words

      for i in [0...5]
        console.log '# ' + i
#        console.log bose.postProcess bose.build data
        console.log bose.builder(data).build()
        console.log '\n'