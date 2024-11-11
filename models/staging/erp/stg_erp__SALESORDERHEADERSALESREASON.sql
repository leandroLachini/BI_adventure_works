/* connection with product sales order header sales reason source.*/

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'SALESORDERHEADERSALESREASON') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(SALESORDERID as int) as PK_SALESORDERID
        , cast(SALESREASONID as int) as FK_SALESREASONID
        from source
    )

select *
from remane_table