-- Question:How has the global temperature changed over time, and is the trend accelerating?




with staging as (
    select *
    from {{ ref('int_temp_by_decade') }}
)

select 
    data_source,
    decade_start, 
    round(avg_temp_anomaly_celsius, 5) as avg_temp_anomaly_celsius,
    lag(round(avg_temp_anomaly_celsius, 5)) over (partition by data_source order by decade_start) as previous_decade_avg,
    round(avg_temp_anomaly_celsius - lag(round(avg_temp_anomaly_celsius, 5)) over (partition by data_source order by decade_start), 5) as temp_change_from_previous_decade
from staging
order by decade_start, data_source





