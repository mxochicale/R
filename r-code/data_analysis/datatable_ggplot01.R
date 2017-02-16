#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           datatable_ggplot00.R
# FileDescription:
#                 Create data.table object and the data is ploted with ggplot
#
# Reference:
# http://stackoverflow.com/questions/41536406/
# how-to-apply-separate-coord-cartesian-to-zoom-in-into-individual-panels-of-a
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


library(data.table)
library(ggplot2)

# data points
dp <- data.table(
  x = c(6.6260, 6.6234, 6.6206, 6.6008, 6.5568, 6.4953, 6.4441, 6.2186,
        6.0942, 5.8833, 5.7020, 5.4361, 5.0501, 4.7440, 4.1598, 3.9318,
        3.4479, 3.3462, 3.1080, 2.8468, 2.3365, 2.1574, 1.8990, 1.5644,
        1.3072, 1.1579, 0.95783, 0.82376, 0.67734, 0.34578, 0.27116, 0.058285),
  y = 1:32,
  deriv = 0)
dp

# # approximated data points and derivatives
ap <- rbindlist(
      lapply(seq(2, length(dp$x), length.out = 4), ## 2 12 22 32
         function(df) {
           rbindlist(
             lapply(0:2,
                    function(deriv) {
                      result <- as.data.table(
                          predict(smooth.spline(dp$x, dp$y, df = df), deriv = deriv))
                          result[, c("df", "deriv") := list(df, deriv)]
                    })
           )
         }
  )
)

ap


ggplot(ap, aes(x,y)) +
geom_line() +
facet_wrap(~ deriv + df, scales = "free_y", labeller = label_both, nrow = 3) +
theme_bw()
