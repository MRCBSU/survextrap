% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/outputs.R
\name{hazard_ratio}
\alias{hazard_ratio}
\title{Hazard ratio against time in a survextrap model}
\usage{
hazard_ratio(
  x,
  newdata = NULL,
  t = NULL,
  tmax = NULL,
  niter = NULL,
  summ_fns = NULL,
  sample = FALSE
)
}
\arguments{
\item{x}{A fitted model object as returned by \code{\link{survextrap}}}

\item{newdata}{A data frame with two rows.  The hazard ratio will
be defined as hazard(second row) divided by hazard(first row).
If the only covariate in the model is a factor with two levels,
then \code{newdata} defaults to a data frame containing the
levels of this factor, so that the hazard ratio for the second
level versus the first level is computed.  For any other models,
\code{newdata} must be supplied explicitly.

Standardisation (with \code{\link{standardise_to}}) is not supported.
This might be done by hand by using \code{hazard(...,sample=TRUE)}
to obtain posterior samples for the two standardised hazards separately,
then summarising by hand.}

\item{t}{Vector of times at which to compute the estimates.}

\item{tmax}{Maximum time at which to compute the estimates.  If
\code{t} is supplied, then this is ignored.  If \code{t} is not
supplied, then \code{t} is set to a set of 100 equally spaced
time points from 0 to \code{tmax}.  If both \code{tmax} and \code{t}
are not supplied, then \code{tmax} is set to the maximum follow up time
in the data.}

\item{niter}{Number of MCMC iterations to use to compute credible
intervals.  Set to a low value to make this function quicker, at the cost of
some approximation error (which may not be important for plotting or model
development).}

\item{summ_fns}{A list of functions to use to summarise the posterior sample.
This is passed to \code{\link[posterior:summarise_draws]{posterior::summarise_draws}}.
By default this is \code{list(median=median, ~quantile(.x, probs=c(0.025, 0.975)))}.
If the list is named, then the names will be used for the columns of the
output.}

\item{sample}{If \code{TRUE} then the MCMC samples are returned instead
of being summarised as a median and 95\% credible intervals.}
}
\value{
A data frame (tibble) with each row containing posterior summary statistics
for different times.

Or if \code{sample=TRUE}, an array with dimensions
\code{length(t)}, \code{niter}, and 1, giving the
incremental RMST evaluated at different times and MCMC iterations
respectively.
}
\description{
Compute the hazard ratio at a series of time points, estimated from
a \code{\link{survextrap}} model.  Intended for use with
non-proportional hazards models
(\code{survextrap(...,nonprop=TRUE)}).  In proportional hazards
models (which \code{\link{survextrap}} fits by default) the hazard
ratio is constant with time.
}
