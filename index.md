# SWIM [![swim website](reference/figures/logo_swim.png)](https://jolenesutton.github.io/swim/)

Functions for **Spatial Weight Informed Mapping (SWIM)**, which enables
integration of data from incongruent sources to generate a heterogeneous
layer of sampling weights. Events missing geographic coordinates are
assigned to a spatial grid using a probability-based framework informed
by the sampling weights (i.e., sampling probabilities are proportional
to assigned weights).

**SWIM** is described in **A framework to map fishing activity from
incomplete data** (DOI: 10.1093/icesjms/fsag070), which was recently
accepted to *ICES Journal of Marine Science*.

## Installation

You can install **SWIM** with:

``` r
# install.packages("devtools")
devtools::install_github("JoleneSutton/swim")
```
