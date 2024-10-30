/* Dimensao localização */

with
    int_location as (
        select
        PK_ADDRESSID
        , CITY
        , STATE_NAME
        , COUNTRY_NAME
        from {{ ref('int_location_joins') }}
    )

select * from int_location
