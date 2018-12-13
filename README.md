# Complexity of Linear Operators

Let $A \in \{0,1\}^{m \times n}$ be a matrix with $t_0$ zeroes
and $t_1$ ones and $x \in S^n$ be an $n$-dimensional vector of
formal variables over a semigroup $(S, \circ)$.
How many semigroup operations are required to compute the linear operator $A x$?

As we show in this paper, this problem generalizes the well-known
range queries problem and has a rich variety of applications in
such areas as graph algorithms, functional programming, circuit complexity,
and others. It is easy to compute $A x$ using a linear number of semigroup
operations with respect to $t_1$, i.e. $O(t_1 + n + m)$, or just $O(t_1)$
in the circuit model of computation.
The main question studied in this paper is:
can $A x$ be computed using $O(t_0+n+m)$ semigroup operations?
We prove that in general this is not possible: there exists
a matrix $A \in \{0,1\}^{n \times n}$ with exactly two zeroes in every row
(hence $m=n$ and $t_0=2n$) whose complexity is $\Theta(n\alpha(n))$
where $\alpha(n)$ is the inverse Ackermann function.
However, for the case when the semigroup is commutative,
we give a constructive proof of an $O(t_0+n+m)$ upper bound.
This implies that in commutative settings, complements of sparse matrices can
be processed as efficiently as sparse matrices (though the corresponding
algorithms are more involved).

As a simple application of the presented linear-size construction, we show
how to multiply two $n\times n$ matrices over an arbitrary semiring in $O(n^2)$
time if one of these matrices is a 0/1 matrix with $O(n)$ zeroes (i.e. a
complement if a sparse matrix). Note that this covers the cases of Boolean and
tropical semirings, which have numerous applications, e.g. in graph theory.
