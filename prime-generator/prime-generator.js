var max = Math.max;
var floor = Math.floor;
var sqrt = Math.sqrt;

function isPrime(x) {

    if (x < 2) {
        return false;
    }

    var startFrom = max(2, floor(sqrt(x)));
    for (var i = startFrom; i < x; i++) {
        if (x % i == 0) {
            return false;
        }
    }

    return true;
}

function getNthPrime(n) {
    var count = 0;
    var i = 1;
    while (count < n) {
        if (isPrime(++i)) {
            count++;
        }
    }
    return i;
}

module.exports = {
    isPrime: isPrime,
    getNthPrime: getNthPrime
};