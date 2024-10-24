/* Dimensao produtos */

with
    staging as (
        select
        *
        from {{ ref("stg_erp__PRODUCT")}}
    )

select * from staging
