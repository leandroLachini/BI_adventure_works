/* connection with buy address source (country layer) */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'COUNTRYREGION') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(COUNTRYREGIONCODE as varchar) as PK_COUNTRYREGIONCODE
        , cast(NAME as varchar) as COUNTRY_NAME
        from source
    )

select * from remane_table
