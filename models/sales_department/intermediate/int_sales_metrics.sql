with
/* Conexao com a staging SALESORDERHEADER */
    sales_header as (
        select *
        from {{ ref('stg_erp__SALESORDERHEADER') }}
    )

/* Conexao com a staging SALESORDERDETAIL */
    , sales_detail as (
        select *
        from {{ ref('stg_erp__SALESORDERDETAIL') }}
    )

/* Conexao com a intermediate salesreason_joins */
    , int_salesreason_joins as (
        select *
        from {{ ref('int_salesreason_joins') }}
    )

/* Fazendo os joins para popular tabela com dados relevantes */
    , joined as (
        select
        --*
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
        , sales_header.FK_SHIPTOADDRESSID as FK_ADDRESSID
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
        left join sales_header 
            on sales_header.PK_SALESORDERID = sales_detail.FK_SALESORDERID
    )

/* Gerando as metricas para analise */
    , metrics as (
        select 
            joined. *
            , {{gross_income('QUANTITY', 'UNIT_PRICE')}}
            , {{net_value('QUANTITY', 'UNIT_PRICE', 'UNITPRICEDISCOUNT')}}
            , cast(GROSS_VALUE - NET_VALUE as numeric(30,4)) as DISCOUNT_VALUE
            --, SALES_QUANTITY * SALES_UNITPRICE
            --    * (1 - DISCOUNT_PERCENT) as NET_VALUE
            --, VALUE_SHIP / (count(*) over(partition by NUMBER_ORDER)) as PRORATED_SHIPPING
            --, case
            --    when DISCOUNT_PERCENT > 0 then true
            --    else false
            --end as HAS_DISCOUNT
        from joined
    )

/* Formato final da tabela com as metricas */
    , final_table as (
        select
        *
        from metrics
    )

select * from final_table
