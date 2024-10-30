/*  
    Este teste garante que a tabela fatos vendas deve possuir:
    31.465 pedidos
*/

with
    total_order as (
        select
            PK_SALESORDERID
        from {{ ref('int_sales_metrics') }}
    ) -- $12.646.112,16

    , disctinct_salesorderid as (
        select
            PK_SALESORDERID
        from total_order
        group by all
    )

    , count_total_order as (
        select
            count(PK_SALESORDERID) as QUANTITY_ORDER
        from disctinct_salesorderid
    )

select QUANTITY_ORDER
from count_total_order
where QUANTITY_ORDER <> 31465
