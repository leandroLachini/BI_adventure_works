/*  
    Este teste garante que as vendas de 2011 estão
    corretas com o valor auditado da contabilidade:
    $12.646.112,16
*/

with
    sales_2011 as (
        select
        sum(GROSS_VALUE) as GROSS_VALUE
        from {{ ref('int_sales_metrics') }}
        where YEAR_ORDER = '2011'
    ) -- $12.646.112,16

select GROSS_VALUE
from sales_2011
where GROSS_VALUE not between 12646112.1 and 12646112.2
