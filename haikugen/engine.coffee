fs = require('fs')
colors = require('colors')
f_context = require('f_context')
_ = require('lodash')

config =
  wordsTotal : 16 # kobzar
#  wordsTotal : 10 # bose
  lineTotal : 4

reverse = (x) -> x.split('').reverse().join('')
upperFirst = (s) -> s[0].toUpperCase() + s.slice(1)
randomInt = (max) -> Math.floor max*Math.random()

#######################################

# улучшить токенайзер:
#  перевести на конечный автомат
#  токенизировать знаки препинания и переносы строк как слова
tokenize = (str) ->
  str
    .split /[^a-zа-яёъєїі\-',]/i
    .filter (x) -> Boolean x.trim()
    .map (x) -> x.toLowerCase()

#######################################

analyze = (words) ->
  res = {}
  prev = null
  words.forEach (curr) ->
    if !res[curr] then res[curr] = {}
    if prev
      if  !res[prev][curr] then res[prev][curr] = 1
      else res[prev][curr]++
    prev = curr
  res = sortSet res
  return res

sortSet = (set) ->
  _.mapValues set, (freqData) ->
    if _.size(freqData) > 1
      freqData = _.pairs freqData
      freqData = _.sortBy freqData, (x) -> -x[1]
      freqData = _.zipObject freqData, null
    else
      freqData

#######################################

fitness = (x, y) ->
  x = reverse x
  y = reverse y
  n = Math.min x.length, y.length
  res = 0
  for i in [0...n]
      if x[i] == y[i] then res++
      else break
  return res

#######################################

builder = (data) ->
  history = []
  lines = []
  line = []
  word = null
  allWords = _.keys data

  compileLine = () ->

    loop

      if !word

        word = pickRandomFrom allWords
        line.push upperFirst word

      else

        if lines.length > 0 && (
          isEnoughForLine(line.length + 1) ||
          isEnoughForHaiku(history.length + 1))

          prevLine = lines[0]
          rhymeWord = prevLine[prevLine.length - 1]
          word = pickRhymedFrom allWords, rhymeWord

        else
          word = pickRandomFrom _.keys data[word]

        line.push word

      history.push word

      break if isEnoughForLine(line.length) ||
               isEnoughForHaiku(history.length)

  isEnoughForLine = (wordInLine) -> wordInLine >= config.lineTotal
  isEnoughForHaiku = (totalWords) -> totalWords >= config.wordsTotal

  pickRandomFrom = (words) -> words[ randomInt(words.length) ]
  pickRhymedFrom = (words, rhymeWord) ->

#    words = _.filter words, (x) -> fitness(x, word) > 0
    words = _.sortBy words, (x) -> -fitness x, word
    words = _.unique words

    console.log words.slice(1, 6)

    word = pickRandomFrom words.slice(0, 10) || ['lol']
    word += '->' +  fitness(word, rhymeWord)
    word

  compile = () ->
    loop
      line = []
      compileLine()
      lines.push line
      break if isEnoughForHaiku(history.length)

  build = () ->
    history = []
    lines = []

    compile()

    lines
    lines = lines.map (x) -> x.join(' ')
    postProcess lines.join('\n') + '.'

  return {
    build
  }

#######################################

postProcess = (s) ->
  s.replace /\s?([,.\-]){2,}/, '$1'

#######################################

module.exports = {
  tokenize,
  analyze,
  postProcess,
  fitness,
  builder
}
