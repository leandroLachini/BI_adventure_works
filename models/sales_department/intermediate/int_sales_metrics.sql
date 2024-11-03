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

/* Select da SALESREASONID = 2 */
    , reason_2 as (
        {{select_reason(2)}}
    )

/* Fazendo os joins para popular tabela com dados relevantes */
    , joined as (
        select
        --*
        sales_detail.FK_SALESORDERID
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
        , reason_2.FK_SALESREASONID
        from sales_detail
        left join sales_header 
            on sales_header.PK_SALESORDERID = sales_detail.FK_SALESORDERID
        left join reason_2 
            on reason_2.PK_SALESORDERID = sales_header.PK_SALESORDERID
    )

/* Gerando as metricas para analise */
    , metrics as (
        select 
            joined. *
            , SUBTOTAL / {{prorated('PK_SALESORDERID')}} as PRORATED_SUBTOTAL
            , TAXA / {{prorated('PK_SALESORDERID')}} as PRORATED_TAXA
            , FREIGHT / {{prorated('PK_SALESORDERID')}} as PRORATED_FREIGHT
            , TOTAL_SALES / {{prorated('PK_SALESORDERID')}} as PRORATED_TOTAL_SALES
            , {{gross_income('QUANTITY', 'UNIT_PRICE')}} as GROSS_VALUE
            , {{net_value('QUANTITY', 'UNIT_PRICE', 'UNITPRICEDISCOUNT')}} as NET_VALUE
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
        FK_SALESORDERID
        , PK_ORDERDETAILID
        , FK_PRODUCTID
        , FK_SPECIALOFFERID
        , QUANTITY
        , UNIT_PRICE
        , UNITPRICEDISCOUNT
        , PK_SALESORDERID
        , FK_STATUSID
        , FK_CUSTOMERID
        , FK_SALESPERSONID
        , FK_TERRITORYID
        , FK_BILLTOADDRESSID       
        , FK_ADDRESSID
        , FK_SHIPMETHODID
        , FK_CREDITCARDID
        , FK_CURRENCYRATEID
        , FK_SALESREASONID
        , ORDERDATE
        , DUEDATE
        , SHIPDATE
        , PRORATED_SUBTOTAL
        , PRORATED_TAXA
        , PRORATED_FREIGHT
        , PRORATED_TOTAL_SALES
        , GROSS_VALUE
        , NET_VALUE
        , DISCOUNT_VALUE
        from metrics
    )

select * from final_table

/* with
    sales_header as (
        select *
        from {{ ref('stg_erp__SALESORDERHEADER') }}
    )
    
    , reason_2 as (
        {{select_reason(2)}}
    )

    , joined as (
        select
        *
        from sales_header
        left join reason_2 on reason_2.PK_SALESORDERID = sales_header.PK_SALESORDERID
    )

select * from joined */
