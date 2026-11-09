# Decarbonizing Chicago's Large Buildings

A data science project on building decarbonization: which of Chicago's large buildings emit the most
greenhouse gas (GHG) per square foot, and what distinct energy-use profiles exist among them. It combines
regression models with k-means clustering on the City of Chicago's energy benchmarking data
(2014–2023). Every analysis is implemented in both **Python** and **R**.

## Dataset

**Chicago Energy Benchmarking** (City of Chicago Data Portal), used under the portal's terms of use:
<https://data.cityofchicago.org/Environment-Sustainable-Development/Chicago-Energy-Benchmarking/xq83-jr8c>

- `data/chicago_energy_benchmarking.csv`: 28,329 building-year reports from 3,852 buildings, 2014–2023,
  30 columns (property type, floor area, year built, location, fuel use, site EUI, ENERGY STAR score,
  GHG emissions and GHG intensity)
- `data/processed/`: cleaned data written by Part 1 (not committed; run Part 1 first, then Parts 2–3)

## Questions

1. **Which building characteristics best predict a building's GHG intensity?** Regression (linear
   regression, regression tree, random forest) using only property type, floor area, age, number of
   buildings, location and year, not energy use.
2. **What distinct energy-use profiles exist among Chicago's large buildings?** k-means clustering on
   energy intensity, GHG intensity and energy mix, with *k* chosen by the elbow and silhouette methods.

## Contents

| Part | Python | R |
|---|---|---|
| 1. Data preparation and exploratory analysis | [`python/01_data_preparation_eda.ipynb`](python/01_data_preparation_eda.ipynb) | [`r/01_data_preparation_eda.Rmd`](r/01_data_preparation_eda.Rmd) ([HTML](r/01_data_preparation_eda.html)) |
| 2. Question 1: predicting GHG intensity (regression) | [`python/02_q1_regression.ipynb`](python/02_q1_regression.ipynb) | [`r/02_q1_regression.Rmd`](r/02_q1_regression.Rmd) ([HTML](r/02_q1_regression.html)) |
| 3. Question 2: energy-use profiles (clustering) | [`python/03_q2_clustering.ipynb`](python/03_q2_clustering.ipynb) | [`r/03_q2_clustering.Rmd`](r/03_q2_clustering.Rmd) ([HTML](r/03_q2_clustering.html)) |

**Report:** [`report/issifu_bernard_buildings_report.pdf`](report/issifu_bernard_buildings_report.pdf)
(5 pages; Markdown source and `build_report.sh` alongside). Document-kit (LaTeX) style:
[`report/kit-version/issifu_bernard_buildings_report.pdf`](report/kit-version/issifu_bernard_buildings_report.pdf).
Figures and result tables from both languages are in `report/figures/`.

## Key results

- **Data:** 21,618 clean building-years; 3,448 buildings in the modelling set (latest report each).
  Median GHG intensity 6.2 kg CO2e/sq ft; 10% of buildings produce 51% of emissions. For the 743
  buildings that reported every year, median GHG intensity fell 19.5% from 2018 to 2023. Python and R
  produce identical cleaned data.
- **Question 1:** building characteristics predict GHG intensity only weakly. Test R² 0.312 (random
  forest), 0.287 (linear regression), 0.223 (regression tree), against 0.276 for property type alone;
  R gives 0.331 / 0.317 / 0.284 / 0.316. Property type dominates (grocery and healthcare emit far more
  per sq ft than apartments, schools and offices); age adds a little; size and location almost nothing.
- **Question 2:** four energy-use profiles (*k* = 4, silhouette 0.378): gas-heated typical (1,946
  buildings, 5.4 kg/sq ft), electric-led low energy use (733, 6.5), energy-intensive poor performers
  (680, 10.4, median ENERGY STAR 26) and district-energy buildings (89, 12.0). The energy-intensive group
  is 20% of buildings but 33% of emissions. R finds the same profiles (sizes within 2 buildings).

## How to run

- **Python:** from `python/`, run the notebooks in order (pandas, numpy, matplotlib, seaborn,
  scikit-learn).
- **R:** from `r/`, render the files in order with `rmarkdown::render("01_data_preparation_eda.Rmd")`
  and so on (dplyr, tidyr, ggplot2, rpart, randomForest, cluster).
- **Report:** from `report/`, run `./build_report.sh` (needs pandoc and Chromium); the LaTeX version is
  built with the document kit's `make_pdf.py` on `report/kit-version/issifu_bernard_buildings_report.md`.
