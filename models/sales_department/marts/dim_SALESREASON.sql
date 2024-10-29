/* Dimensao motivo da compra */

with
    int_salesreason as (
        select
            PK_SALESREASONID
            , NAME_SALESREASON
            , TYPE_SALESREASON
        from {{ ref('stg_erp__SALESREASON') }}
    )

select * from int_salesreason
