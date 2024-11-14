/* Dimension Payment */

with
    staging as (
        select
        PK_CREDITCARDID
        , CARDTYPE
        from {{ ref("stg_erp__CREDITCARD")}}
    )

select * from staging
