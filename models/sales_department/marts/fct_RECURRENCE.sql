/* Fact Recurrence */

with
    int_recurrence as (
        select
            *
        from {{ ref('int_sales_metrics_recurrence') }}
    )

select * from int_recurrence