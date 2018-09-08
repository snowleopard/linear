# Complexity of Dense Linear Operators

We study the complexity of *dense matrices*, i.e. 0/1 matrices of size
N×N with O(N) zeroes. More specifically, we are interested in the
complexity of computing the *dense linear operator* A**x**, where A is a
dense matrix and **x** is a vector over an arbitrary semigroup: How many
semigroup operations are required to simultaneously compute all values
of the resulting vector?

Our two main results are: (i) we present a linear-size construction for the case
when the semigroup is commutative, and (ii) we prove that the non-commutative
case is strictly harder and is equivalent to the classic Range Queries
problem -- the corresponding O(Nα(N))-size circuits can be readily obtained
by applying the Yao's Range Queries algorithm, where α(N) is the inverse
Ackermann function, and this construction is asymptotically optimal.

As a simple application of the presented linear-size construction, we show that
an N×N matrix can be multiplied by a dense matrix over an arbitrary
semiring in O(N<sup>2</sup>) time.
