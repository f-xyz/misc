function main() {
    var n = 1e6;
    var k = 2, i;
    function testFunctional() {
        bench(function() {
            var p = PointsFunc(1, 2, 3);
            p.add(4, 4, 4);
            return p.length();
        }, 'functional', n)
    }
    function testObject() {
        bench(function() {
            var p = PointsObject(1, 2, 3);
            p.add(4, 4, 4);
            return p.length();
        }, 'object', n)
    }
    function testProto() {
        bench(function() {
            var p = new PointsProto(1, 2, 3);
            p.add(4, 4, 4);
            return p.length();
        }, 'proto', n)
    }
    for (i = k; --i;) {
        console.log('#' + (k-1));
        testFunctional();
        testObject();
        testProto();
    }
    console.log('\n');
    console.log('Exit (Y/n):');
    process.stdin.on('data', function (/*buffer*/) {
        process.exit();
    });
}

function bench(f, message, n) {
    console.time(message);
    var sum = 0;
    for (var i = n; i--;) sum += f();
    console.timeEnd(message);
    //console.log(sum);
}

var PointsFunc = (function PointsFuncModule() {
    return function point(x, y, z) {

        function add(ax, ay, az) {
            x += ax;
            y += ay;
            z += az;
        }

        function length() {
            return Math.sqrt(x*x + y*y + z*z);
        }

        function get() {
            return { x: x, y: y, z: z }
        }

        return {
            add: add,
            length: length,
            get: get
        };
    }
}());

var PointsObject = (function PointsObjectModule() {
    return function point(x, y, z) {
        return {
            add: function(x, y, z) {
                this.x += x;
                this.y += y;
                this.z += z;
            },
            length: function() {
                return Math.sqrt(x*x + y*y + z*z);
            }
        };
    }
}());

var PointsProto = (function PointsModuleProto() {
    function Point(x, y, z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }
    Point.prototype.add = function (x, y, z) {
        this.x += x;
        this.y += y;
        this.z += z
    };
    Point.prototype.length = function () {
        return Math.sqrt(this.x*this.x + this.y*this.y + this.z*this.z);
    };
    return Point;
}());

main();
