const Y = (h) => (
    (f) => f(f)
)(
    (f) => h((n) => f(f)(n))
);

const fact = Y((g) => (x) => x <= 1 ? 1 : x * g(x - 1));

describe('Y combinator tests', () => {
    it('', () => {
        console.log(fact(3));
        console.log(fact(4));
        console.log(fact(5));
    });
});
