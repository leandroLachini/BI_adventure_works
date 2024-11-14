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
    , order_sales as (
        select 
            FK_CUSTOMERID,
            ORDERDATE,
            LAG(ORDERDATE) over(partition by FK_CUSTOMERID order by ORDERDATE) AS LAST_ORDERDATE
        from 
            joined
    )

/* calculate days_between_orderdate */
    , recurrence as (
        select 
            FK_CUSTOMERID,
            DATEDIFF(DAY, LAST_ORDERDATE, ORDERDATE) AS DAYS_BETWEEN_ORDERDATE
        from 
            order_sales
        where 
            LAST_ORDERDATE IS NOT NULL
    )

/* generating metrics for analysis */
    , metrics as (
        select 
            FK_CUSTOMERID,
            COUNT(*) AS TOTAL_SALES,
            AVG(DAYS_BETWEEN_ORDERDATE) AS AVG_DAYS_BETWEEN_ORDERDATE
        from 
            recurrence
        group by 
            FK_CUSTOMERID
        order by 
            FK_CUSTOMERID
    )

/* order average days between orderdate */
    , order_recurrence as (
        select
            metrics.*
            , case
                when AVG_DAYS_BETWEEN_ORDERDATE >= 90 then 'NO'
                when AVG_DAYS_BETWEEN_ORDERDATE < 90 then 'YES'
                end as IS_RECURRENCE
        from metrics
    )

/* Final table format */
    , final_table as (
        select
            FK_CUSTOMERID
            ,TOTAL_SALES
            ,AVG_DAYS_BETWEEN_ORDERDATE
            ,IS_RECURRENCE
        from order_recurrence
    )

select * from final_table
