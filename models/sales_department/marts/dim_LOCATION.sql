/* Dimensao localização */

with
    int_location as (
        select
        *
        from {{ ref('int_location_joins') }}
    )

select * from int_location
