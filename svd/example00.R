#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           example00.R
# Description:
#
#
# References:
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


A = as.matrix(data.frame(c(4,7,-1,8), c(-5,-2,4,2), c(-1,3,-3,6)))
A

# A.svd <- svd(A)
# A.svd

ATA <- t(A) %*% A
ATA


ATA.e <- eigen(ATA)
v.mat <- ATA.e$vectors
v.mat



# Here we see the V matrix is the same as the output of the svd() but with some
# sign changes. These sign changes can happen, as mentioned earlier, as the
# eigenvector scaled by −1 is still the same eigenvector, just scaled.
# We will alter the signs of our calculated V
#



# to match the output of the svd() function.

v.mat[,1:2] <- v.mat[,1:2] * -1
v.mat



AAT <- A %*% t(A)
AAT


AAT.e <- eigen(AAT)
u.mat <- AAT.e$vectors
u.mat

u.mat <- u.mat[,1:3]
# Note the eigenvalues of AAT and ATA are the same except the 0 eigenvalue in the AAT matrix.


# As mentioned earlier, the singular values r are the square roots of the non-zero eigenvalues of the AAT and ATA
# matrices.

r <- sqrt(ATA.e$values)
r <- r * diag(length(r))[,1:3]
r


# Our answers align with the output of the svd() function. We can also show that the matrix A
# is indeed equal to the components resulting from singular value decomposition.

svd.matrix <- u.mat %*% r %*% t(v.mat)
svd.matrix
