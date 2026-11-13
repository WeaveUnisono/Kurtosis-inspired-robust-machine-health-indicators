# Robust Kurtosis Estimators (MATLAB)

A MATLAB implementation of classical and robust kurtosis estimators based on moments, quantiles, L-moments, trimmed L-moments, and LQ-moments used in the paper entitled "Kurtosis-inspired robust machine health indicators under non-Gaussian noise environment" by Aleksandra Grzesiek, Daniel Kuzio, Justyna Witulska, Radosław Zimroz, Tomasz Barszcz, and Agnieszka Wyłomańska.

The project provides a collection of statistical estimators designed to measure the kurtosis of a distribution, including alternatives to the classical moment-based estimator that are less sensitive to extreme observations and heavy-tailed data.

## Overview

Kurtosis is a statistical measure describing the shape of a probability distribution, particularly its tail behavior.

The classical moment-based estimator is defined as

K = m4 / m2^2,

where \(m2\) and \(m4\) are the second and fourth central sample moments.

Although widely used, classical kurtosis can be highly sensitive to outliers and extreme observations. This motivates the use of robust alternatives based on quantiles, order statistics, and L-moments.

This repository implements several approaches to kurtosis estimation, allowing their properties and behavior to be investigated and compared.

## Implemented estimators

### 1. Classical and moment-based estimators

- **Classical kurtosis** – the standard fourth standardized central moment (Pearson kurtosis, not excess kurtosis).
- **Trimmed kurtosis** – classical kurtosis calculated after removing a specified proportion of observations from both tails.
- **Winsorized kurtosis** – classical kurtosis calculated after replacing extreme observations with the nearest retained order statistics.

### 2. Quantile-based estimators

- **Moors kurtosis** – based on octiles of the empirical distribution.
- **Hogg kurtosis** – based on differences between means of lower and upper sample tails.
- **Crow–Siddiqui kurtosis** – based on the ratio of the 95% central range to the interquartile range.

### 3. L-moment-based estimators

- **L-kurtosis** – defined as the ratio of the fourth L-moment to the second L-moment.
- **TL-kurtosis** – based on trimmed L-moments, allowing additional control over the influence of extreme order statistics.

### 4. LQ-kurtosis estimators

The repository includes a general implementation of LQ-kurtosis and three specific variants:

- **LQ-median kurtosis**
- **LQ-trimean kurtosis**
- **LQ-Gastwirth kurtosis**

These estimators use quantiles of order-statistic distributions and provide a flexible framework for constructing robust kurtosis measures.

## Repository structure

```text
robust_kurtosis_matlab/
│
├── estimators/
│   ├── rk_classical.m
│   ├── rk_trimmed.m
│   ├── rk_winsorized.m
│   │
│   ├── rk_moors.m
│   ├── rk_hogg.m
│   ├── rk_crow_siddiqui.m
│   ├── rk_emp_quantile.m
│   ├── rk_quantile_sorted.m
│   │
│   ├── rk_lmoment.m
│   ├── rk_lmoments.m
│   ├── rk_tlmoment.m
│   ├── rk_tlmoment_value.m
│   │
│   ├── rk_lq_kurtosis.m
│   ├── rk_lq_median.m
│   ├── rk_lq_trimean.m
│   ├── rk_lq_gastwirth.m
│   │
│   └── rk_binom_small.m
│
└── run_validation_normal.m
```

## Requirements

- MATLAB (tested on Matlab 2024b),
- MATLAB functions supporting numerical computation, including `betaincinv` and `betainc`-related functionality where applicable.
- No external toolboxes are explicitly required by the provided implementation.

The validation script also uses MATLAB functionality for random number generation and tabular output.

## Installation

Clone or download the repository:

```bash
git clone https://github.com/YOUR_USERNAME/robust_kurtosis_matlab.git
```

Navigate to the project directory in MATLAB.

Add the estimator directory to the MATLAB path:

```matlab
addpath(fullfile(pwd, 'estimators'));
```

All estimator functions can now be called directly.

## Usage

All estimators accept a numerical sample as input. The sample can be provided as a row or column vector.

### Basic example

```matlab
% Generate a random sample
rng(123);
x = randn(10000, 1);

% Calculate different kurtosis estimators
K_classical = rk_classical(x);
K_trimmed   = rk_trimmed(x, 0.05);
K_winsor    = rk_winsorized(x, 0.05);

K_moors     = rk_moors(x);
K_hogg      = rk_hogg(x);
K_crow      = rk_crow_siddiqui(x);

K_lmoment   = rk_lmoment(x);
K_tlmoment  = rk_tlmoment(x, 1, 1);

K_lq_median = rk_lq_median(x);
K_lq_trimean = rk_lq_trimean(x);
K_lq_gastwirth = rk_lq_gastwirth(x);
```

### Quantile calculation methods

Quantile-based estimators support two quantile calculation conventions:

- `ecdf` – inverse empirical CDF, using the order statistic with index \(\lceil np \rceil\).
- `mh98` – linear interpolation following the convention used by Mudholkar and Hutson (1998).

The default method is `ecdf`.

Example:

```matlab
K1 = rk_moors(x, 'ecdf');
K2 = rk_moors(x, 'mh98');

K3 = rk_crow_siddiqui(x, 'ecdf');
```

### Custom LQ-kurtosis

The general LQ-kurtosis estimator allows the parameters \(p\) and \(\alpha\) to be specified.

```matlab
K = rk_lq_kurtosis(x, p, alpha);
```

The parameters must satisfy:

0 ≤ p ≤ 0.5,
0 ≤ α ≤ 0.5.

The predefined variants correspond to:

| Estimator | \(p\) | \(α\) |
|---|---:|---:|
| LQ-median | 0 | 0.5 |
| LQ-trimean | 0.25 | 0.25 |
| LQ-Gastwirth | 0.3 | 1/3 |

## Validation and Monte Carlo experiment

The repository includes `run_validation_normal.m`, a simulation script designed to investigate the behavior of the implemented estimators under normally distributed data.

The experiment uses:

| Parameter | Value |
|---|---:|
| Distribution | Standard normal |
| Sample size per replication | 10,000 |
| Number of replications | 1,000 |
| Trimming / winsorization fraction | 0.05 |
| Quantile method | ECDF |
| Random seed | 20260919 |

For each replication, a sample is generated from the standard normal distribution and all implemented estimators are evaluated.

The script calculates:

- Monte Carlo mean;
- Monte Carlo standard deviation;
- Bias relative to the theoretical or specified reference value.

The reference values for the standard normal distribution are included in the script. Reference values for trimmed and winsorized kurtosis are left undefined because they depend on the trimming or winsorization procedure.

### Running the validation

From the MATLAB command window:

```matlab
run_validation_normal
```

The results are displayed as a MATLAB table.

## Implementation notes

- All estimators operate on vector samples and internally convert them into column vectors.
- Order-statistic-based methods sort the observations before calculation.
- The classical estimator returns Pearson kurtosis, for which the theoretical value under a normal distribution is 3.
- The implementation of L-moments and trimmed L-moments follows unbiased sample-moment formulations.
- Quantile-based methods allow the quantile convention to be selected explicitly.

The estimators are provided as separate MATLAB functions to facilitate independent use, comparison, and extension.

## License

MIT License.

**Keywords:** Robust Statistics, Kurtosis, MATLAB, L-moments, TL-moments, LQ-kurtosis, Quantile Estimators, Order Statistics, Monte Carlo Simulation.
