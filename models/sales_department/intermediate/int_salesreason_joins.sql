/* Conexao com a staging HeaderSalesReason */

with
    header_sales_reason as (
        select
        *
        from {{ ref("stg_erp__SALESORDERHEADERSALESREASON")}}
    )

/* Conexao com a staging SalesReason */
    
    , sales_reason as (
        select
        *
        from {{ ref("stg_erp__SALESREASON")}}
    )

/* Fazendo os joins para popular tabela com dados relevantes */

    , joined as (
        select
        header_sales_reason.PK_SALESORDERID
        , sales_reason.PK_SALESREASONID
        , sales_reason.NAME_SALESREASON
        , sales_reason.TYPE_SALESREASON
        from header_sales_reason
        left join sales_reason on sales_reason.PK_SALESREASONID = header_sales_reason.FK_SALESREASONID
    )

select * from joined
