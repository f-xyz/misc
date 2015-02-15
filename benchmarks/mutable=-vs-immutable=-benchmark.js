var colors = require('colors');

function main() {
    const n = 1e8;
    const k = 1;

    var a = {};
    var b = 2;
    var u;

    function testMutable() {
        function Point(x, y, z) {
            this.x = x;
            this.y = y;
            this.z = z;
        }
        Point.prototype = {
            add: function(x, y, z) {
                this.x += x;
                this.y += y;
                this.z += z;
            }
        };
        console.log(new Point(1, 2, 3));

        var point = new Point();

        bench(function() {
            point.add(1, -1, 0.5);
            return point;
        }, 'mutable', n)
    }

    function testImmutable() {

        function Point(x, y, z) {
            this.x = x;
            this.y = y;
            this.z = z;
        }
        Point.prototype = {
            add: function(x, y, z) {
                this.x += x;
                this.y += y;
                this.z += z;
            }
        };
        console.log(new Point(1, 2, 3));

        var point = new Point();

        bench(function() {
            point.add(1, -1, 0.5);
            return point;
        }, 'immutable', n)
    }

    console.log('\n');
    for (var i = 1; i <= k; i++) {
        if (k > 1) {
            console.log(colors.bold(
                'Iteration # ' + i + ' of ' + k + '.'));
        }
        testMutable();
        testImmutable();
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