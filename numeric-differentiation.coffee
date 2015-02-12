should = require('chai').should()
sqrt = Math.sqrt
sqr = (x) -> x*x
dist = (pa, pb) -> 
    sqrt (
        sqr pa[0] - pb[0] + 
        sqr pa[1] - pb[1] + 
        sqr pa[2] - pb[2] 
    )

e = 1e-6

grad3d = (f, x, y, z) -> [
    ( f(x + e, y, z) - f(x - e, y, z) ) / e / 2,
    ( f(x, y + e, z) - f(x, y - e, z) ) / e / 2,
    ( f(x, y, z + e) - f(x, y, z - e) ) / e / 2,
]

describe 'tests', ->

    it 'plane function', ->
        f = (x, y, z) -> y
        res = grad3d f, 0, 0, 0
        console.dir res
        
    it 'sphere function', ->
        R = 5
        f = (x, y, z) -> dist([0, 0, 0], [x, y, z]) - R
        res = grad3d f, 5, 0, 0
        console.dir res