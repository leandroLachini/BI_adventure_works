/* Dimensao motivo da compra */

with
    int_customer as (
        select
        *
        from {{ ref('int_salesreason_joins') }}
    )

select * from int_customer
