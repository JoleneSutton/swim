# Swim Sample

Sample spatial grid cells and distribute events according to grid cell
sample weights

## Usage

``` r
sw_sample(length, wghts, option = 1)
```

## Arguments

- length:

  The number of events

- wghts:

  Data frame with two columns. The first column is the identity of the
  grid cell. The second column is the associated sampling weight. If
  choosing option=3, the column of sampling weights is ignored.

- option:

  Either 1, 2, or 3. Default is 1. Option 1 uses weighted random
  assignment to distribute events over grid cells. This option returns
  grid cell identities. Option 2 distributes events over all grid cells
  proportionally according to the sampling weights. Option 3 distributes
  events evenly over all available grid cells, ignoring sampling
  weights.
