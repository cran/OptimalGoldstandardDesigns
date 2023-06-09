% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/design_display_functions.R
\name{print.OneStageGoldStandardDesign}
\alias{print.OneStageGoldStandardDesign}
\title{Printing method for optimal single-stage goldstandard designs}
\usage{
\method{print}{OneStageGoldStandardDesign}(x, ...)
}
\arguments{
\item{x}{An object of class OneStageGoldStandardDesign}

\item{...}{additional parameters}
}
\value{
returns the input x invisibly. This functions is used for its side effects, i.e. printing
design characteristics to the screen.
}
\description{
Printing method for optimal single-stage goldstandard designs
}
\examples{
# Should take about 2 second with the chosen accuracy
optimize_design_onestage(
  alpha = .025,
  beta = .2,
  alternative_TP = .4,
  alternative_TC = 0,
  Delta = .2,
  mvnorm_algorithm = mvtnorm::Miwa(steps = 512, checkCorr = FALSE, maxval = 1000),
  nloptr_opts = list(algorithm = "NLOPT_LN_SBPLX", ftol_rel = 1e-03, xtol_abs = 1e-08,
                     xtol_rel = 1e-07, maxeval = 1000, print_level = 0)
)

}
