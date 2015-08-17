require('chai').should();
var isPrime = require('./prime-generator').isPrime;
var getNthPrime = require('./prime-generator').getNthPrime;

describe('isPrime()', function () {

    var isNumberPrime = [
        false, false, true, true,
        false, true, false, true,
        false, false, false, true,
        false, true, false, false
    ];

    for (var i = 0; i < 16; i++) {
        var testName = 'isPrime('+i+') == ' + isNumberPrime[i];
        it(testName, function (i) {
            isPrime(i).should.eq(isNumberPrime[i]);
        }.bind(null, i));
    }

    it('negatives are not prime', function () {
        isPrime(-1).should.be.false;
    });
});

describe('getNthPrime()', function () {
    var nThPrime = [2, 3, 5, 7];
    for (var i = 1; i <= nThPrime.length; i++) {
        var testName = 'getNthPrime('+i+') == ' + nThPrime[i-1];
        it (testName, (function (i) {
            return function () {
                getNthPrime(i).should.eq(nThPrime[i-1]);
            };
        })(i));
    }

    it('500th prime is 3571', function () {
        getNthPrime(500).should.eq(3571);
    });
});
