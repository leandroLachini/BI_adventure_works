/* Dimensao Status da Pedido */

with
    seed as (
        select
        *
        from {{ref("seed_status_name")}}
    )

select * from seed
