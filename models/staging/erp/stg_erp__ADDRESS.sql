/* connection with buy address source (city layer) */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'ADDRESS') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(ADDRESSID as int) as PK_ADDRESSID
        , cast(STATEPROVINCEID as int) as FK_STATEPROVINCEID
        , cast(CITY as varchar) as CITY
        from source
    )

select * from remane_table
