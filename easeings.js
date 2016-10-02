'use strict';

///////////////////////////////////////////////////////////////////////////////
// UNTESTED
///////////////////////////////////////////////////////////////////////////////

module.exports = {

    /**
     * Elastic.
     * @param {Number} t 0..1
     * @returns {Number}
     */
    elastic: function (t) {
        const t2 = t*t;
        const t3 = t2*t;

        return (-8.1525*t3*t2)
             + (28.5075*t2*t2)
             + (-35.105*t3)
             + ( 16.0*t2)
             + (-0.25*t)
        ;
    },

    /**
     * Another bounce.
     * @param {Number} t 0..1
     * @param {Number} [freq] Default: 0.3;
     * @returns {Number}
     */
    bounce: function (t, freq) {
        if (t === 0) return 0;
        if (t === 1) return 1;

        freq = freq || 0.3;

        return Math.pow(2, -10*t)
             * Math.sin((t - freq/4) * 2*Math.PI/freq)
             + 1
        ;
    },

    /**
     * Another bounce.
     * @param {Number} t 0..1
     * @returns {Number}
     */
    jumps: function (t) {
        if (t < 1 / 2.75) {
            return 7.5625*t*t;
        } else if (t < 2 / 2.75) {
            t -= 1.5 / 2.75;
            return 7.5625*t*t + 0.75;
        } else if (t < 2.5 / 2.75) {
            t -= 2.25 / 2.75;
            return 7.5625*t*t + 0.9375;
        } else {
            t -= 2.625 / 2.75;
            return 7.5625*t*t + 0.984375;
        }
    }

};