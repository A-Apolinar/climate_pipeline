Welcome to your new dbt project!

# Climate Pipeline

a dbt data pipeline analyzing global surface temperature anomalies 
using real data from NASA and NOAA. Built to practice moden 
analytics engineering with dbt Core and DuckDB

## What This Project Does

This pipeline ingest global temperature anomaly data from
two independant scientific sources, NASA GISTEMP and NOAA GCAG,
and transforms it into a decade-by-decade trend analysis showing
how surface temperatures have changed since 1850.

The final output shows average temperature anomalies per decade 
per data source, the change from previous decade, and a clear
warming trend that accelerates through the 20th and 21st centuries.

## Data Sources

- **NASA GISTEMP v4** — GISS Surface Temperature Analysis, 
  global land-ocean temperature index. 
  Source: https://data.giss.nasa.gov/gistemp/
- **NOAA GCAG** — Global component of Climate at a Glance. 
  Source: https://www.ncei.noaa.gov/access/monitoring/climate-at-a-glance/

Both datasets measure temperature anomalies in degrees Celsius 
relative to a baseline average, updated monthly.

## Pipeline Structure
```
seeds/
  global_temp_annual.csv        # Raw NOAA/NASA annual temperature data

models/
  staging/
    stg_global_temp_annual.sql  # Cleans and renames raw source data
  intermediate/
    int_temp_by_decade.sql      # Aggregates annual data into decade averages
  marts/
    mart_trend_over_time.sql    # Final trend analysis with window functions
```

### Layer Descriptions

**Staging** — Renames raw columns to readable names, filters nulls, 
validates that data only comes from expected sources (GCAG, GISTEMP).

**Intermediate** — Groups annual temperature anomalies into decades 
and calculates the average anomaly per decade per data source.

**Marts** — Applies window functions (LAG, PARTITION BY) to calculate 
the temperature change from each decade to the previous one, 
producing the final analysis-ready table.

## Key Findings

- Global temperature anomalies show a consistent upward trend 
  from 1850 to present
- Both NASA and NOAA datasets show strong agreement in trend direction
- Decade-over-decade warming accelerates in the late 20th and 
  early 21st century, with changes of approximately +0.2°C per decade

## Tech Stack

- **dbt Core** — Data transformation and modeling
- **DuckDB** — Local analytical database
- **Python** — Environment management
- **SQL** — All transformation logic

## How to Run This Project

### Prerequisites
- Python 3.13+
- dbt Core with dbt-duckdb adapter

### Setup

Clone the repository:
```bash
git clone https://github.com/A-Apolinar/climate_pipeline.git
cd climate_pipeline
```

Create and activate a virtual environment:
```bash
python -m venv .venv
.venv\Scripts\activate  # Windows
```

Install dbt:
```bash
pip install dbt-core dbt-duckdb
```

### Run the Pipeline
```bash
dbt seed      # Load raw NOAA/NASA data
dbt run       # Build all models
dbt test      # Validate data quality
```

### View Documentation
```bash
dbt docs generate
dbt docs serve
```

Opens an interactive documentation site showing all models, 
column descriptions, and test coverage.

## Project Status

Active. Planned extensions:
- Add NOAA storm events data with geospatial coordinates
- Incorporate NASA solar flare data (DONKI API)
- Add Python ingestion scripts to automate data refresh
```
