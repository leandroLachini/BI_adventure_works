/* connection with product sales order header source.*/

with
    source as (
        select 
        *
        from {{ source('erp_adventure_works', 'SALESORDERHEADER') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(SALESORDERID as int) as PK_SALESORDERID
        ,cast(STATUS as int) as FK_STATUSID
        ,cast(CUSTOMERID as int) as FK_CUSTOMERID
        ,cast(SALESPERSONID as int) as FK_SALESPERSONID
        ,cast(TERRITORYID as int) as FK_TERRITORYID
        ,cast(BILLTOADDRESSID as int) as FK_BILLTOADDRESSID
        ,cast(SHIPTOADDRESSID as int) as FK_SHIPTOADDRESSID
        ,cast(SHIPMETHODID as int) as FK_SHIPMETHODID
        ,cast(CREDITCARDID as int) as FK_CREDITCARDID
        ,cast(CURRENCYRATEID as int) as FK_CURRENCYRATEID
        ,cast(ORDERDATE as date) as ORDERDATE
        ,cast(DUEDATE as date) as DUEDATE
        ,cast(SHIPDATE as date) as SHIPDATE
        ,cast(SUBTOTAL as numeric(18,2)) as SUBTOTAL
        ,cast(TAXAMT as numeric(18,2)) as TAXA
        ,cast(FREIGHT as numeric(18,2)) as FREIGHT
        ,cast(TOTALDUE as numeric(18,2)) as TOTAL_SALES
        from source
    )

select * from remane_table
