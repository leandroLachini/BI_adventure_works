/* Dimensao localização */

with
    int_location as (
        select
        FK_TERRITORYID
        , CITY
        , STATE_NAME
        , COUNTRY_NAME
        from {{ ref('int_location_joins') }}
    )

select * from int_location
