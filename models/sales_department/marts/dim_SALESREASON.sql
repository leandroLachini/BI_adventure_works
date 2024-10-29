/* Dimensao motivo da compra */

with
    stg_salesreason as (
        select
             PK_SALESREASONID
            , NAME_SALESREASON
            , TYPE_SALESREASON
        from {{ ref('stg_erp__SALESREASON') }}
    )

select * from stg_salesreason
