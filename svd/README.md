

Singular value decomposition can be thought of as a method that transforms
correlated variables into a set of uncorrelated variables, enabling one to better
analyze the relationships of the original data (Baker, 2005).
SVD factors a matrix A into a product of three matrices: A=UΣVT

Where the columns of matrices U
and V are orthonormal (orthogonal unit vectors) and Σ is a diagonal matrix.
The columns of U and V are the eigenvectors of AAT and ATA, respectively.
The entries in the diagonal matrix Σ are the singular values r, which are the
square roots of the non-zero eigenvalues of AAT and ATA

https://rpubs.com/aaronsc32/singular-value-decomposition-r



The singular value decomposition can be computed using the following observations:

    The left-singular vectors of M are a set of orthonormal eigenvectors of MM∗.
    The right-singular vectors of M are a set of orthonormal eigenvectors of M∗M.
    The non-zero singular values of M (found on the diagonal entries of Σ) are the square roots of the non-zero eigenvalues of both M∗M and MM∗.

https://en.wikipedia.org/wiki/Singular_value_decomposition




Eigenvectors remain eigenvectors after multiplication by a scalar (including -1).
The proof is simple:
If v is an eigenvector of matrix A with matching eigenvalue c, then by definition Av=cv.
Then, A(-v) = -(Av) = -(cv) = c(-v). So -v is also an eigenvector with the same eigenvalue.
The bottom line is that this does not matter and does not change anything.
https://stackoverflow.com/questions/17998228/sign-of-eigenvectors-change-depending-on-specification-of-the-symmetric-argument
