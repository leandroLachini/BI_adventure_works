/* Dimensao clientes */

with
    int_customer as (
        select
        *
        from {{ ref('int_customer_joins') }}
    )

select
*
from int_customer
