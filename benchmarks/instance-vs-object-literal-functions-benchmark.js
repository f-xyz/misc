var colors = require('colors');

function main() {
    const n = 1e7;
    const k = 1;

    function testInstance() {
        function A() { }
        A.prototype.f = function(a, b) { return a + b };
        var a = new A();
        bench(function() {
            return a.f(i, i+1);
        }, 'prototype', n)
    }

    function testObjectLiteral() {
        var a = {
            f: function(a, b) { return a + b }
        };
        bench(function() {
            return a.f(i, i+1);
        }, 'object literal', n)
    }

    function testRevealingObjectLiteral() {
        function f(a, b) { return a + b }
        var a = { f: f };
        bench(function() {
            return a.f(i, i+1);
        }, 'revealing object literal', n)
    }

    console.log('\n');
    for (var i = 1; i <= k; i++) {
        if (k > 1) {
            console.log(colors.bold(
                'Iteration # ' + i + ' of ' + k + '.'));
        }
        testInstance();
        testObjectLiteral();
        testRevealingObjectLiteral();
    }
}

function bench(f, message, iterations) {
    var lastResult;
    var timeStart = Date.now();

    console.log(colors.yellow(colors.bold(message)));

    for (var i = 0; i < iterations; ++i) {
        lastResult = f(i);
    }

    var timeSpent = Date.now() - timeStart;
    console.log(colorize(
        '  Took ' +
        colors.bold(timeSpent + ' ms'), timeSpent));
    console.log('  Last result: ' + lastResult + '\n');
    return { timeSpent: timeSpent, lastResult: lastResult };
}

function colorize(str, time) {
    return time > 1000 && colors.red(str)
        || time > 250  && colors.yellow(str)
        ||                colors.green(str);
}

function printAndWait() {
    console.log('Press Enter to step');
    console.log('or Ctrl+C to exit.');
    process.stdin.on('data', function (buffer) {
        console.log('Received: :', buffer);
        process.exit();
    });
}

main();
printAndWait();