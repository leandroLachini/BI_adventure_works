/* connection with buy address source (state layer) */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'STATEPROVINCE') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(STATEPROVINCEID as int) as PK_STATEPROVINCEID
        , cast(COUNTRYREGIONCODE as varchar) as FK_COUNTRYREGIONCODE
        , cast(TERRITORYID as varchar) as FK_TERRITORYID
        , cast(NAME as varchar) as STATE_NAME
        from source
    )

select * from remane_table
