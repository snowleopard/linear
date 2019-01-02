# Complexity of Linear Operators

Let **A** be an **n×n** 0/1-matrix with **z** zeroes and **u** ones and **x** be
an **n**-dimensional vector of formal variables over a semigroup **(S, ∘)**.
How many semigroup operations are required to compute the linear operator **Ax**?

As we observe in this paper, this problem contains as a special case the well-known
range queries problem and has a rich variety of applications in such areas as graph
algorithms, functional programming, circuit complexity, and others. It is easy to
compute **Ax** using **O(u)** semigroup operations. The main question studied in
this paper is: can **Ax** be computed using **O(z)** semigroup operations? We prove
that in general this is not possible: there exists a matrix **A** with exactly two
zeroes in every row (hence **z=2n**) whose complexity is **Θ(nα(n))** where **α(n)**
is the inverse Ackermann function. However, for the case when the semigroup is
commutative, we give a constructive proof of an **O(z)** upper bound. This implies
that in commutative settings, complements of sparse matrices can be processed as
efficiently as sparse matrices (though the corresponding algorithms are more
involved). Note that this covers the cases of Boolean and tropical semirings that
have numerous applications, e.g., in graph theory.

As a simple application of the presented linear-size construction, we show how to
multiply two **n×n** matrices over an arbitrary semiring in **O(n^2)** time if one
of these matrices is a 0/1-matrix with **O(n)** zeroes (i.e., a complement of a 
sparse matrix).
