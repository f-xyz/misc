(function () {
    var i, s = 0.0, n = 1e9;

    console.time('const');
    //(function () {
        const b = 123*20;
        for (i = 0; i < n; ++i) {
            s += b - 123;
        }
    //})();
    console.timeEnd('const');

    var a = 123.0*20.0;
    console.time('var');
    for (i = 0; i < n; ++i) {
        s += a - 123.4;
    }
    console.timeEnd('var');
})();