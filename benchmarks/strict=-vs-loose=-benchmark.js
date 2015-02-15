var colors = require('colors');

function main() {
    const n = 1e5;
    const k = 1;

    var a = {};
    var b = 2;
    var u;

    function testString() {
        bench(function() {
            return a === b;
        }, 'strict equality: {} === 2', n)
    }

    function testLoose() {
        bench(function() {
            return a == b;
        }, 'loose equality: {} == 2', n)
    }

    function testExistenceTypeof() {
        bench(function() {
            return typeof u === 'undefined';
        }, 'existence: typeof u === \'undefined\'', n)
    }

    function testExistenceUndefined() {
        bench(function() {
            return u === undefined;
        }, 'existence: u === undefined', n)
    }

    function testExistenceSimple() {
        bench(function() {
            return !u;
        }, 'existence: !u', n)
    }

    console.log('\n');
    for (var i = 1; i <= k; i++) {
        if (k > 1) {
            console.log(colors.bold(
                'Iteration # ' + i + ' of ' + k + '.'));
        }
        testString();
        testLoose();
        testExistenceTypeof();
        testExistenceUndefined();
        testExistenceSimple();
    }
}

function bench(f, message, iterations) {
    var lastResult;
    var timeStart = Date.now();

    console.log(colors.yellow(colors.bold(message)));

    while (iterations--) {
        lastResult = f();
    }

    var timeSpent = Date.now() - timeStart;
    console.log(colorize(
        '  Took ' +
        colors.bold(timeSpent + ' ms'), timeSpent));
    console.log('  Last result: ' + lastResult + '\n');
    return { timeSpent: timeSpent, lastResult: lastResult };
}

function colorize(str, time) {
    if (time > 1000) {
        return colors.red(str);
    } else if (time > 250) {
        return colors.yellow(str);
    } else {
        return colors.green(str);
    }
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