/* Dimensao motivo da compra */

with
    int_customer as (
        select
        PK_SALESORDERID
        , PK_SALESREASONID
        , NAME_SALESREASON
        , TYPE_SALESREASON
        from {{ ref('int_salesreason_joins') }}
    )

select * from int_customer
