/* Dimensao Pagamentos Cartão */

with
    staging as (
        select
        *
        from {{ ref("stg_erp__CREDITCARD")}}
    )

select * from staging
