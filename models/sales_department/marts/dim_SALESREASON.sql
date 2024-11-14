/* Dimension Sales Reason */

with
    int_salesreason as (
        select
            SK_SALESREASON
            , PK_SALESORDERID
            , NAMES_SALESREASON
        from {{ ref('int_salesreason_joins') }}
    )

select * from int_salesreason
