

with source as (
    select * from {{ ref('global_temp_annual') }}
),

renamed as (
    select
        upper(source) as data_source,
        year          as year,
        mean          as temp_anomaly_celsius
    from source
    where mean is not null
)

select * from renamed

