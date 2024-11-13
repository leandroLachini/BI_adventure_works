/*  
    Este teste garante que a tabela dimensão produtos deve possuir:
    mais de 500 produtos
*/

with
    total_product as (
        select
            PK_PRODUCTID
        from {{ ref('int_product_joins') }}
    )

    , disctinct_product as (
        select
            PK_PRODUCTID
        from total_product
        group by all
    )

    , count_total_product as (
        select
            count(PK_PRODUCTID) as QUANTITY_PRODUCT
        from disctinct_product
    )

select QUANTITY_PRODUCT
from count_total_product
where QUANTITY_PRODUCT < 500
