% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimization_methods.R
\name{optimize_design_twostage}
\alias{optimize_design_twostage}
\title{Calculate optimal design parameters for a two-stage gold-standard design}
\usage{
optimize_design_twostage(
  cT2 = NULL,
  cP1 = NULL,
  cP2 = NULL,
  cC1 = NULL,
  cC2 = NULL,
  bTP1f = NULL,
  bTP1e = NULL,
  bTC1f = NULL,
  bTC1e = NULL,
  alpha = 0.025,
  beta = 0.2,
  alternative_TP = 0.4,
  alternative_TC = 0,
  Delta = 0.2,
  varT = 1,
  varP = 1,
  varC = 1,
  binding_futility = FALSE,
  always_both_futility_tests = TRUE,
  round_n = TRUE,
  lambda = 1,
  kappa = 0,
  eta = 0,
  objective = quote(sqrt(lambda)^2 * ASN[["H11"]] + (1 - sqrt(lambda)) * sqrt(lambda) *
    ASN[["H10"]] + (1 - sqrt(lambda)) * sqrt(lambda) * ASN[["H01"]] + (1 -
    sqrt(lambda))^2 * ASN[["H00"]] + kappa * (sqrt(lambda)^2 * ASNP[["H11"]] + (1 -
    sqrt(lambda)) * sqrt(lambda) * ASNP[["H10"]] + (1 - sqrt(lambda)) * sqrt(lambda) *
    ASNP[["H01"]] + (1 - sqrt(lambda))^2 * ASNP[["H00"]] + eta * cumn[[2]][["P"]]) + eta
    * (cumn[[2]][["T"]] + cumn[[2]][["P"]] + cumn[[2]][["C"]])),
  inner_tol_objective = .Machine$double.eps^0.25,
  mvnorm_algorithm = mvtnorm::Miwa(steps = 128, checkCorr = FALSE, maxval = 1000),
  nloptr_x0 = NULL,
  nloptr_lb = NULL,
  nloptr_ub = NULL,
  nloptr_opts = list(algorithm = "NLOPT_LN_SBPLX", ftol_rel = 1e-04, xtol_abs = 0.001,
    xtol_rel = 0.01, maxeval = 1000, print_level = 0),
  print_progress = TRUE,
  ...
)
}
\arguments{
\item{cT2}{(numeric) allocation ratio nT2 / nT1. Parameter to be optimized if left unspecified.}

\item{cP1}{(numeric) allocation ratio nP1 / nT1. Parameter to be optimized if left unspecified.}

\item{cP2}{(numeric) allocation ratio nP2 / nT1. Parameter to be optimized if left unspecified.}

\item{cC1}{(numeric) allocation ratio nC1 / nT1. Parameter to be optimized if left unspecified.}

\item{cC2}{(numeric) allocation ratio nC2 / nT1. Parameter to be optimized if left unspecified.}

\item{bTP1f}{(numeric) first stage futility boundary for the T vs. P testing problem. Parameter to be optimized if left unspecified.}

\item{bTP1e}{(numeric) first stage critical value for the T vs. P testing problem. Parameter to be optimized if left unspecified.}

\item{bTC1f}{(numeric) first stage futility boundary for the T vs. C testing problem. Parameter to be optimized if left unspecified.}

\item{bTC1e}{(numeric) first stage critical value for the T vs. C testing problem. Parameter to be optimized if left unspecified.}

\item{alpha}{type I error rate.}

\item{beta}{type II error rate.}

\item{alternative_TP}{assumed difference between T and P under H1. Positive values favor T.}

\item{alternative_TC}{assumed difference between T and C under H1. Positive values favor T.}

\item{Delta}{non-inferiority margin for the test \eqn{X_T - X_C \leq - \Delta} vs.
\eqn{X_T - X_C > - \Delta}.}

\item{varT}{variance of treatment group.}

\item{varP}{variance of placebo group.}

\item{varC}{variance of control group.}

\item{binding_futility}{(logical) controls if futility boundaries are binding.}

\item{always_both_futility_tests}{(logical) if true, both futility tests are performed after the first stage. If false,
a 'completely sequential' testing procedure is employed (see Appendix of \insertCite{meis2023optimization}{OptimalGoldstandardDesigns}).}

\item{round_n}{(logical) if TRUE, a design with integer valued sample sizes is returned.}

\item{lambda}{(numeric) weight of the alternative hypothesis in the default objective function. 1-lambda is the weight
of the null hypothesis.}

\item{kappa}{(numeric) penalty factor for placebo patients in the default objective function.}

\item{eta}{(numeric) penalty factor for the maximum sample size in the default objective function.}

\item{objective}{(expression) objective criterion.}

\item{inner_tol_objective}{(numeric) used to determine the tolerances for integrals and nuisance optimization problems
inside the objective function.}

\item{mvnorm_algorithm}{algorithm for multivariate integration passed to \code{\link[mvtnorm]{pmvnorm}}.}

\item{nloptr_x0}{(numeric vector) starting point for optimization.}

\item{nloptr_lb}{(numeric vector) lower bound box for box constrained optimization.}

\item{nloptr_ub}{(numeric vector) upper bound box for box constrained optimization.}

\item{nloptr_opts}{(list) nloptr options. See \code{\link[nloptr]{nloptr}}.}

\item{print_progress}{(logical) controls whether optimization progress should be visualized during the calculation.}

\item{...}{additional arguments passed along.}
}
\value{
Design object (a list) with optimized design parameters.
}
\description{
Calculate optimal design parameters for a two-stage gold-standard design
}
\details{
This function calculates optimal design parameters for a two-stage three-arm gold-standard
non-inferiority trial. Run \code{vignette("Introduction", package = "OptimalGoldstandardDesigns")}
to see some examples related to the associated paper \insertCite{meis2023optimization}{OptimalGoldstandardDesigns}.

Parameters which can be optimized are the allocation ratios for all groups and stages and the
futility and efficacy boundaries of the first stage. The allocation ratios are
cT2 = nT2 / nT1, cP1 = nP1 / nT1,
cP2 = nP2 / nT1, cC1 = nC1 / nT1 and cC2 = nC2 / nT1. Here, nT1 denotes the sample size
of the treatment group in the first stage, nP2 the sample size of the placebo group in the
second stage, etc. The first stage efficacy boundaries are bTP1e for the treatment vs
placebo testing problem, and bTC1e for the treatment vs control non-inferiority testing
problem. The futility boundaries are denoted by bTP1f and bTC1f.

If these parameters are left unspecified or set to NULL, they will be included into the
optimization process, otherwise they will be considered boundary constraints.
You may also supply quoted expressions as arguments for these
parameters to solve a constrained optimization problem. For example, you can supply
\code{cT2 = 1, cP2 = quote(cP1), cC2 = quote(cC1)} to ensure that the first and second
stage allocation ratios are equal.

The design is optimized with respect to the objective criterion given by the parameter
\code{objective}. The default objective function is described in the
Subsection \emph{Optimizing group sequential gold-standard designs} in Section 2
of \insertCite{meis2023optimization}{OptimalGoldstandardDesigns}. Additionally,
this objective includes a term to penalize the maximum sample size of a trial,
which can be controlled by the parameter \code{eta} (default is \code{eta=0}).

Designs are calculated to fulfill the following constraints: the family-wise type I error
rate is controlled at \code{alpha} under any combination of the two null hypotheses
\code{muT - muP = 0} and \code{muT - muC + Delta = 0}.
The power to reject both hypothesis given both alternative
hypotheses \code{muT - muP = alternative_TP} and \code{muT - muC + Delta = alternative_TC + Delta}
is at least \code{1 - beta}. Variances are assumed to be given by \code{varT, varP} and \code{varC}.

If \code{binding_futility} is \code{TRUE}, type I error recycling is used.
If \code{always_both_futility_tests} is \code{TRUE}, it is assumed that futility tests for both
hypotheses are performed at interim, regardless of whether the treatment vs placebo null hypothesis
was successfully rejected. If \code{always_both_futility_tests} is \code{FALSE}, the futility
test for the treatment vs. control testing problem only needs to be done if the null for the
treatment vs. placebo testing problem was rejected in the first stage.
}
\examples{
# Should take about 15 seconds.
\donttest{
optimize_design_twostage(
  cT2 = 1,
  cP2 = quote(cP1),
  cC2 = quote(cC1),
  bTP1f = -Inf,
  bTC1f = -Inf,
  beta = 0.2,
  alternative_TP = 0.4,
  alternative_TC = 0,
  Delta = 0.2,
  binding_futility = TRUE,
  lambda = .9,
  kappa = 1,
  nloptr_opts = list(algorithm = "NLOPT_LN_SBPLX", ftol_rel = 1e-01)
)
}
}
\references{
\insertAllCited{}
}
