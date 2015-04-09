camelCase = (x) ->
  if x then x[0].toLowerCase() + x.slice(1)
  else ''

transform = (validation) ->
  validation.reduce (res, x) ->
    key = camelCase(x.property) || '_common'
    if key !of res
      res[key] = x.messages
    else
      res[key] = res[key].concat(x.messages)
    res
  , {}

module.exports = { transform, camelCase }