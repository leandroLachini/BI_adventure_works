with
/* conection with staging SALESORDERHEADER */
    sales_header as (
        select *
        from {{ ref('stg_erp__SALESORDERHEADER') }}
    )

/* conection with staging SALESORDERDETAIL */
    , sales_detail as (
        select *
        from {{ ref('stg_erp__SALESORDERDETAIL') }}
    )

/* making joins to populate a table with relevant data */
    , joined as (
        select
        sales_header.FK_CUSTOMERID
        , sales_header.ORDERDATE
        from sales_detail
        left join sales_header 
            on sales_header.PK_SALESORDERID = sales_detail.FK_SALESORDERID
    )

/* get orderdate and last_orderdate */
, order_sales AS (
    SELECT 
        FK_CUSTOMERID,
        ORDERDATE,
        LAG(ORDERDATE) OVER(PARTITION BY FK_CUSTOMERID ORDER BY ORDERDATE) AS LAST_ORDERDATE
    FROM 
        joined
)

/* calculate days_between_orderdate */
, recurrence AS (
    SELECT 
        FK_CUSTOMERID,
        DATEDIFF(DAY, LAST_ORDERDATE, ORDERDATE) AS DAYS_BETWEEN_ORDERDATE
    FROM 
        order_sales
    WHERE 
        LAST_ORDERDATE IS NOT NULL
)

/* generating metrics for analysis */
, metrics as (
    SELECT 
        FK_CUSTOMERID,
        COUNT(*) AS TOTAL_SALES,
        AVG(DAYS_BETWEEN_ORDERDATE) AS AVG_DAYS_BETWEEN_ORDERDATE
    FROM 
        recurrence
    GROUP BY 
        FK_CUSTOMERID
    ORDER BY 
        FK_CUSTOMERID
)

/* generating metrics for analysis */
, order_recurrence as (

    select
        metrics.*
        , case
            when AVG_DAYS_BETWEEN_ORDERDATE >= 90 then 'NO'
            when AVG_DAYS_BETWEEN_ORDERDATE < 90 then 'YES'
            end as IS_RECURRENCE
    from metrics
)

/* Final table */
select * from order_recurrence
