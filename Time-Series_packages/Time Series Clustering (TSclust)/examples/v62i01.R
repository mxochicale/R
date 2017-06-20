# load the package
library("TSclust")

##### EXAMPLE 1 SYNTHETIC SERIES DATASET #####

# load the dataset
data("synthetic.tseries")
# create the true cluster solution
true_cluster <- rep(1:6, each = 3)

# create distance matrix for the integrated periodogram dissimilarity
IP.dis <- diss(synthetic.tseries, "INT.PER")
# hierarchical cluster solution
IP.hclus <- cutree(hclust(IP.dis), k = 6)
# rate the solution based on the implemented cluster similarity
cluster.evaluation(true_cluster, IP.hclus)

library("cluster")
# partition against medoids solution
IP.pamclus <- pam(IP.dis, k = 6)$clustering
# rate the solution based on the implemented cluster similarity
cluster.evaluation(true_cluster, IP.pamclus)
# show the solution
IP.pamclus

# analyzed Autocorrelation based solution
ACF.dis <- diss(synthetic.tseries, "ACF", p = 0.05)
ACF.hclus <- cutree(hclust(ACF.dis), k = 6)
cluster.evaluation(true_cluster, ACF.hclus)

ACF.pamclus <- pam(ACF.dis, k = 6)$clustering
cluster.evaluation(true_cluster, ACF.pamclus)
ACF.hclus

# dissimilarity based on ARMA models, take the p-value

AR.MAH.PVAL.dis <- diss(synthetic.tseries, "AR.MAH")$p_value
# p-value clustering method
AR.MAH.PVAL.clus <- pvalues.clust(AR.MAH.PVAL.dis, 0.05)
cluster.evaluation(true_cluster, AR.MAH.PVAL.clus)
AR.MAH.PVAL.clus
pvalues.clust(AR.MAH.PVAL.dis, 0.6)

# nonparametric spectral approximation dissimilarity, high computational
# requirements
LLR.dis <- diss(synthetic.tseries, "SPEC.LLR", meth = "LK", n = 500)
LLR.pam <- pam(LLR.dis, k = 6)$clustering
cluster.evaluation(true_cluster, LLR.pam)
LLR.pam


##### EXAMPLE 2.1 INTEREST RATES DATASET - PREDICTION BASED DISTANCE #####

# load the dataset
data("interest.rates")

# since the dissimilarity is bootstrap based, set a seed for reproducibility
set.seed(35000)

# sample plot of the prediction densities from which the distance is calculated,
# the prediction is done at an horizon h=6 steps

diss.PRED(interest.rates[, 13], interest.rates[, 16], h = 6, B = 2000, logarithm.x = TRUE, 
  logarithm.y = TRUE, differences.x = 1, differences.y = 1, plot = T)$L1dist

# prepare the correct differences and logarithms for all the countries involved
# in the dataset
diffs <- rep(1, ncol(interest.rates))
logs <- rep(TRUE, ncol(interest.rates))

set.seed(74748)
# compute the distance at for the dataset, high computational requirements
dpred <- diss(interest.rates, "PRED", h = 6, B = 1200, logarithms = logs, differences = diffs, 
  plot = T)
# preform hierarchical clustering and plot the dendogram
hc.dpred <- hclust(dpred$dist)

plot(hc.dpred, main = "", sub = "", xlab = "", ylab = "")


##### EXAMPLE 2.2 INTEREST RATES DATASET - DISSIMILARITY COMPARISON #####

# data are properly transformed
relative.rate.change <- diff(log(interest.rates), 1)
# 5-cluster solutions will be stored in 'Five.cluster.sol'' matrix
Five.cluster.sol <- matrix(0, nrow = 18, ncol = 3)
colnames(Five.cluster.sol) <- c("ACF", "LNP", "PIC")
rownames(Five.cluster.sol) <- colnames(relative.rate.change)
# obtaining the 5-cluster solutions with diss.ACF, diss.PER and diss.AR.PIC
Five.cluster.sol[, 1] <- cutree(hclust(diss(relative.rate.change, "ACF", p = 0.05)), 
  k = 5)
Five.cluster.sol[, 2] <- cutree(hclust(diss(relative.rate.change, "PER", normalize = TRUE, 
  logarithm = TRUE)), k = 5)
Five.cluster.sol[, 3] <- cutree(hclust(diss(relative.rate.change, "AR.PIC")), k = 5)
# show the solution
Five.cluster.sol


##### PAIRS DATASET #####

# load time series dataset
data("paired.tseries")

# ground truth for the first branch experiment, when two elements are joined
# together they appear in the merge field with negative sign, see ?hclust
true_pairs <- data.frame(-matrix(1:36, nrow = 2, byrow = F))

# euclidean
deucl <- diss(paired.tseries, "EUCL")
hceucl <- hclust(deucl, "complete")
# count within the hierarchical cluster the pairs
Qeucl <- sum(true_pairs %in% data.frame(t(hceucl$merge)))/18
Qeucl

# CID distance
dcid <- diss(paired.tseries, "CID")
hccid <- hclust(dcid, "complete")
Qcid <- sum(true_pairs %in% data.frame(t(hccid$merge)))/18
Qcid

# PDC with automatic selection of the embedding dimension
dpdc <- diss(paired.tseries, "PDC")
hcpdc <- hclust(dpdc, "complete")
Qpdc <- sum(true_pairs %in% data.frame(t(hcpdc$merge)))/18
Qpdc

# apply 'as-is' CDM
dcdm <- diss(paired.tseries, "CDM", "gz")
hccdm <- hclust(dcdm, "complete")
Qcdm <- sum(true_pairs %in% data.frame(t(hccdm$merge)))/18
Qcdm

# SAX illustration
testseries <- as.ts(cbind(paired.tseries[, 16], paired.tseries[, 28]))
colnames(testseries) <- c("Series 16", "Series 28")
SAX.plot(testseries, w = 20, alpha = 5)


# for numerical reasons, a symbolic representation could provide better results
# we can use SAX, since it is used in the reference paper and implemented in the
# package

# normalization, PAA reduction and SAX symbolization
tsersax <- apply(paired.tseries, 2, function(x) {
  x <- (x - mean(x))/sd(x)
  x <- PAA(x, w = 343)
  convert.to.SAX.symbol(x, alpha = 27)
})
tsersax <- as.ts(tsersax)

dcdmsymb <- diss(tsersax, "CDM", "gz")
hccdmsymb <- hclust(dcdmsymb, "ward")
Qcdmsymb <- sum(true_pairs %in% data.frame(t(hccdmsymb$merge)))/18
Qcdmsymb

# force embedding dimension of 5 and time delay 8, for better results
dpdc_m5t8 <- diss(paired.tseries, "PDC", m = 5, t = 8)
hcpdc_m5t8 <- hclust(dpdc_m5t8, "complete")
Qpdc_m5t8 <- sum(true_pairs %in% data.frame(t(hcpdc_m5t8$merge)))/18
Qpdc_m5t8

##### EXTRA EXAMPLE : ELECTRICITY DATASET #####

# load the electricity dataset
data("electricity")

# single pair example
diss.CORT(electricity[, 1], electricity[, 21], k = 3, deltamethod = "DTW")


# CORT dissimilarity
distcort1 <- diss(electricity, "CORT", k = 3, deltamethod = "DTW")

# perform hierarchical cluster and plot the results
hc1 <- hclust(distcort1, "average")
plot(hc1)

# select a three cluster solution from the dendogram and show the results
clustcort1 <- cutree(hc1, k = 3)
clustcort1


# alternative cluster using CORT but with no weight for the dynamic behavior (raw DTW)
distcort2 <- diss(electricity, "CORT", k = 0, deltamethod = "DTW")
hc2 <- hclust(distcort2, "average")
# select three cluster and compare with the previous solution that uses dynamics
# behavior
clustcort2 <- cutree(hc2, k = 3)
clustcort2

# compare their silhouette coefficients
library("cluster")
# compute the Silhouette coefficients with diss.CORT and k=3
silh1 <- silhouette(clustcort1, distcort1)
# compute the Silhouette coefficients with diss.CORT and k=0
silh2 <- silhouette(clustcort2, distcort2)
# Silhouette plots associated with silh1 and silh2
plot(silh1, main = "k=3")
plot(silh2, main = "k=0") 
