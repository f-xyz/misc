_ = require('lodash')

draw = (chain) ->
  _(chain)
  .map (freqData, word) ->
    "#{word}\n".bold + drawFollowers freqData
  .join '\n'

drawFollowers = (freqData) ->
  _(freqData)
  .map (v, k) -> "    #{k} #{v}"
  .join '\n'

module.exports = draw