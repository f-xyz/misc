fs = require('fs')
colors = require('colors')
f_context = require('f_context')
_ = require('lodash')

config =
  wordsTotal : 10 # kobzar
#  wordsTotal : 10 # bose
  lineTotal : 4
  scheme: [
    [3, 5],
    [3, 5],
    [1, 4]
  ],
  rhythm: [2]

reverse = (x) -> x.split('').reverse().join('')
upperFirst = (s) -> s[0].toUpperCase() + s.slice(1)
randomInt = (max) -> Math.floor max*Math.random()

#######################################

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

build = (chain) -> buildChain chain, [], 0, ''

buildChain = (chain, freqData, i, prevWord) ->
  if isEnd i then return '.'

  words = []

  if freqData
    words = _.keys freqData

  if words.length == 0
    words = _.keys chain

  rndWord = pickRandom words, prevWord

  s = ''

  if isNewLine i
    s += '\n'

  if i == 0 then s += upperFirst rndWord
  else s += rndWord

  s += ' '

  s += buildChain chain, chain[rndWord], ++i, rndWord

  return s

#######################################

pickRandom = (words) ->
  # y = N - x
#  words = _.sortBy words, (x) -> fitness x, prevWord
  words[ randomInt(words.length) ]

isEnd = (i) ->
  i >= config.wordsTotal

isNewLine = (i) ->
  i > 0 && i % config.lineTotal == 0

#######################################

builder = (data) ->
  history = []
  lines = []
  line = []
  word = null

  compileLine = () ->

    loop

      if !word
        word = pickRandom _.keys data
        line.push upperFirst word
      else
        word = pickRandom _.keys data[word]
        line.push word

      history.push word

      break if shouldNewLine() || shouldEnd()

  shouldNewLine = () -> line.length >= config.lineTotal
  shouldEnd = () -> history.length >= config.wordsTotal

  compile = () ->
    loop
      line = []
      compileLine()
      lines.push line
      break if shouldEnd()

  build = () ->
    history = []
    lines = []

    compile()

    lines = _.map lines, (x) -> x.join(' ')
    lines.join('\n') + '.'

  return {
    build
  }

#######################################

postProcess = (s) ->
  s
    .replace /\s([,.])/, '$1'
    .replace /\s?([,.\-]){2,}/, '$1'

#######################################

module.exports = {
  tokenize,
  analyze,
  build,
  postProcess,
  fitness,
  builder
}