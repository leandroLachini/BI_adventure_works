with
    sales_header as (
        select *
        from {{ ref('stg_erp__SALESORDERHEADER') }}
    )

    , sales_detail as (
        select *
        from {{ ref('stg_erp__SALESORDERDETAIL') }}
    )

    , joined as (
        select
        sales_detail.SK_SALESORDERDETAIL
        , sales_detail.FK_SALESORDERID
        , sales_detail.PK_ORDERDETAILID
        , sales_detail.FK_PRODUCTID
        , sales_detail.FK_SPECIALOFFERID
        , sales_detail.QUANTITY
        , sales_detail.UNIT_PRICE
        , sales_detail.UNITPRICEDISCOUNT
        , sales_header.PK_SALESORDERID
        , sales_header.FK_STATUSID
        , sales_header.FK_CUSTOMERID
        , sales_header.FK_SALESPERSONID
        , sales_header.FK_TERRITORYID
        , sales_header.FK_BILLTOADDRESSID       
        , sales_header.FK_SHIPTOADDRESSID
        , sales_header.FK_SHIPMETHODID
        , sales_header.FK_CREDITCARDID
        , sales_header.FK_CURRENCYRATEID
        , sales_header.ORDERDATE
        , sales_header.DUEDATE
        , sales_header.SHIPDATE
        , sales_header.SUBTOTAL
        , sales_header.TAXA
        , sales_header.FREIGHT
        , sales_header.TOTAL_SALES 
        from sales_detail
        left join sales_header on sales_header.PK_SALESORDERID = sales_detail.FK_SALESORDERID
    )

    , metrics as (
        select 
            *
            , {{gross_income('QUANTITY', 'UNIT_PRICE')}}
            , {{year('ORDERDATE')}}
            , {{net_value('QUANTITY', 'UNIT_PRICE', 'UNITPRICEDISCOUNT')}}
            --, SALES_QUANTITY * SALES_UNITPRICE
            --    * (1 - DISCOUNT_PERCENT) as NET_VALUE
            --, VALUE_SHIP / (count(*) over(partition by NUMBER_ORDER)) as PRORATED_SHIPPING
            --, case
            --    when DISCOUNT_PERCENT > 0 then true
            --    else false
            --end as HAS_DISCOUNT
        from joined
    )

    , final_table as (
        select
        *
        from metrics
    )

select * from final_table
