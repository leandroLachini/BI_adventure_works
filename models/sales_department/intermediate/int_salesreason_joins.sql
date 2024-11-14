with
/* conection with staging HeaderSalesReason */
    header_sales_reason as (
        select
        *
        from {{ ref("stg_erp__SALESORDERHEADERSALESREASON")}}
    )

/* conection with staging SalesReason */
    , sales_reason as (
        select
        *
        from {{ ref("stg_erp__SALESREASON")}}
    )

/* making joins to populate a table with relevant data */
    , joined_reason as (
        select
            header_sales_reason.PK_SALESORDERID
            , LISTAGG(sales_reason.NAME_SALESREASON, ', ') as ALL_NAME_SALESREASON
        from header_sales_reason
        left join sales_reason 
            on header_sales_reason.FK_SALESREASONID = sales_reason.PK_SALESREASONID
        group by 
            header_sales_reason.PK_SALESORDERID
    )

    , has_on_promotion as (
        select
            PK_SALESORDERID
            , coalesce(ALL_NAME_SALESREASON, 'No Reason') as NAMES_SALESREASON
            , PK_SALESORDERID || NAMES_SALESREASON AS SK_SALESREASON_JOIN
        from joined_reason
    )

    , final_reason as (
        select
            {{ dbt_utils.generate_surrogate_key(['SK_SALESREASON_JOIN']) }} AS SK_SALESREASON
            , PK_SALESORDERID
            , NAMES_SALESREASON
        from has_on_promotion
    )

select *
from final_reason
