


with staging as (
    select *
    from {{ ref('stg_global_temp_annual') }}
),

decade_averages as (
    select
        data_source,
        floor(year / 10) * 10 as decade_start,
        avg(temp_anomaly_celsius) as avg_temp_anomaly_celsius
    from staging
    group by 1, 2
)

select * from decade_averages
order by decade_start

