/*  
    Este teste garante que a tabela dimensão clientes deve possuir:
    Aproximadamente 20.000 clientes
*/

with
    total_customer as (
        select
            PK_CUSTOMERID
        from {{ ref('int_customer_joins') }}
    )

    , disctinct_customerid as (
        select
            PK_CUSTOMERID
        from total_customer
        group by all
    )

    , count_total_customer as (
        select
            count(PK_CUSTOMERID) as QUANTITY_CUSTOMER
        from disctinct_customerid
    )

select QUANTITY_CUSTOMER
from count_total_customer
where QUANTITY_CUSTOMER < 19800
