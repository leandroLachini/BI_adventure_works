/* connection with creditcard source.*/

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'CREDITCARD') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(CREDITCARDID as int) as PK_CREDITCARDID
        , cast(CARDTYPE as varchar) as CARDTYPE
        from source
    )

select * from remane_table
