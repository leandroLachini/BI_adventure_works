/* Fact Sales */

with
    int_sales as (
        select
            *
        from {{ ref('int_sales_metrics') }}
    )

select * from int_sales
