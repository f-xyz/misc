#!/usr/bin/env coffee

colors  = require('colors')
argv    = require('optimist').argv

fact = (x) ->
  if x == 2
    return 2
  else if x < 2 
    return 1
  else 
    return x * fact(--x)

fib = (n) ->
  n--
  seq = [1, 1]
  for i in [2..n]
    seq.push seq[i-2] + seq[i-1]
  return seq[n]

isPrime = (x) ->
  if x == 2 
    return true
  for i in [2..Math.sqrt(x)]
    if x % i == 0 
      return false
  return true

getNthPrime = (n) ->
  count = 0
  prime = null
  i = 1
  while count < n 
    if isPrime ++i
      count++
  return i
    
console.log [0..10].map fact
console.log [1..10].map fib
console.log [1..10].map getNthPrime
console.log getNthPrime 1e3
