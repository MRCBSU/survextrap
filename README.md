# survextrap 

`survextrap` is an R package for parametric survival modelling with either or both of: 

1. A standard individual-level, right-censored survival dataset, e.g.

<table> 
<tr>
<th>Survival time</th>
<th>Death</th>
<th>Predictors...</th>
</tr> 

<tr>
<td> 2 years </td>
<td> Yes </td>
<td></td>
</tr>

<tr>
<td> 5 years </td>
<td> No </td>
<td></td>
</tr>

<tr>
<td>etc...</td>
<td></td>
</tr>

</table>

2. (optionally) "External" data sources in the following aggregate "count" form:

<table> 
<tr>
<th colspan="2">Follow-up period </th>
<th colspan="2">Number</th>
<th>Predictors...</th>

</tr> 
<tr><th>Start time $t$</th><th>End time $u$</th><th>Alive at $t$</th><th>Still alive at $u$</th>
<th></th>
</tr>

<tr>
<td> $t_{1}$ </td>
<td> $u_{1}$ </td>
<td> $n_{1}$ </td>
<td> $r_{1}$ </td>
<td></td>
</tr>

<tr>
<td> $t_{2}$ </td>
<td> $u_{2}$ </td>
<td> $n_{2}$ </td>
<td> $r_{2}$ </td>
<td></td>
</tr>

<tr>
<td>etc...</td>
<td></td>
<td></td>
<td></td>
<td></td>

</tr>

</table>

Any number of rows can be supplied for the "external" data, and the time intervals do not have to be distinct or exhaustive. 

Many forms of external data that might be useful for survival extrapolation (such as population data, registry data or elicited judgements) can be manipulated into this common "count" form.

### Principles

* Extrapolations from short-term individual level data should be done using _explicit data or judgements_ about how risk will change over time. 

* Extrapolations should not rely on standard parametric forms (e.g. Weibull, log-normal, gamma...) that are only used out of convention and do not have interpretations as plausible _mechanisms_ for how risk will change over time.

* Instead of selecting (or averaging) traditional parametric models, an _arbitrarily flexible_ parametric model should be used, that _adapts_ to give the optimal fit to the short-term and long-term data in combination.


### How it works 

* Bayesian multiparameter evidence synthesis is used to jointly model all sources of data and judgements.

* An M-spline is used to represent how the hazard changes through time (as in [rstanarm](https://arxiv.org/abs/2002.09633)).  The Bayesian fitting method automatically chooses the optimal level of smoothness and flexibility.  Spline "knots" should span the period covered by the data, and any future period where there is a chance that the hazard may vary.  Then if there is no data in the future period, the uncertainty will be acknowledged and the predicted hazards will have wide credible intervals.

* A proportional hazards model or a flexible non-proportional hazards model can be used to describe the relation of survival to predictors. 

* Mixture cure, relative survival and treatment effect waning models are supported.

* It has an R interface, designed to be friendly to those familiar with standard R modelling functions.

* [Stan](https://mc-stan.org/) is used under the surface to do MCMC (Hamiltonian Monte Carlo) sampling from the posterior distribution, in a similar fashion to [rstanarm](https://mc-stan.org/rstanarm/) and [survHE](https://CRAN.R-project.org/package=survHE). 

* Estimates and posterior summaries and samples for outputs, such as survival, hazard and (restricted) mean survival, can easily be extracted.


### Technical details of the methods

The model is fully described in a paper: [Jackson, BMC Medical Research Methodology (2023)](https://doi.org/10.1186/s12874-023-02094-1).   See also `vignette("methods")`.

`vignette("priors")` goes into detail on how prior distributions and judgements can be specified in `survextrap` - an important but often-neglected part of Bayesian analysis. 

### Evaluation of the methods

Two papers by Timmins et al. describe simulation studies that show good performance of the methods for (a) [short-term estimation from individual-level data](https://arxiv.org/abs/2503.21388) and (b) [extrapolation including external data](https://arxiv.org/abs/2505.16835).


### Examples of how to use it 

`vignette("examples")` gives a rapid tour of each feature, using simple textbook examples and simulated data.

The [cetuximab case study](https://chjackson.github.io/survextrap/articles/cetuximab.html) is a more in-depth demonstration of how `survextrap` could be used in a typical health technology evaluation, based on clinical trial, disease registry, general population and elicited data.  This vignette accompanies Section 4 of the preprint [paper](https://arxiv.org/abs/2306.03957).


### Slides from presentations about survextrap

* [PSI, June 2025](https://chjackson.github.io/survextrap/cjackson_survextrap_psi.pdf)

* [Belfast (RSS NI), December 2023](https://chjackson.github.io/survextrap/cjackson_survextrap_belfast.pdf)

* [Royal Statistical Society, September 2023](https://chjackson.github.io/survextrap/cjackson_survextrap_rss23.pdf)

* [R-HTA, York, June 2023](https://chjackson.github.io/survextrap/cjackson_survextrap_rhta.pdf)

* [Exeter, October 2022](https://chjackson.github.io/survextrap/cjackson_survextrap_exeter.pdf)



## Installation

The package can be installed in the usual way from CRAN, as:

```
install.packages("survextrap")
```

The latest development version on Github can be installed as

```
remotes::install_github("chjackson/survextrap")
```

or more easily as (but a day behind the code on Github)

```
install.packages("survextrap", repos=c('https://chjackson.r-universe.dev',
                                       'https://cloud.r-project.org'))
```

Please give feedback and suggestions if you use it.  These can be posted on [github issues](https://github.com/chjackson/survextrap/issues), or [email](mailto:chris.jackson@mrc-bsu.cam.ac.uk).

<!-- badges: start -->
[![lifecycle](lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/chjackson/survextrap/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/chjackson/survextrap/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://codecov.io/gh/chjackson/survextrap/branch/master/graph/badge.svg)](https://app.codecov.io/gh/chjackson/survextrap)
<!-- badges: end -->
