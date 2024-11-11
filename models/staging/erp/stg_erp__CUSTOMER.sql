/* connection with customer source.*/

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'CUSTOMER') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(CUSTOMERID as int) as PK_CUSTOMERID
        , cast(PERSONID as int) as FK_PERSONID
        , cast(STOREID as int) as FK_STOREID
        , cast(TERRITORYID as int) as FK_TERRITORYID
        from source
    )

select *
from remane_table