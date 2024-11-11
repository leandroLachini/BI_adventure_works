/* connection with product sales order detail source.*/

with
    source as (
        select 
        *
        from {{ source('erp_adventure_works', 'SALESORDERDETAIL') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(SALESORDERID as int) as FK_SALESORDERID
        , cast(SALESORDERDETAILID as int) as PK_ORDERDETAILID
        , cast(PRODUCTID as int) as FK_PRODUCTID
        , cast(SPECIALOFFERID as int) as FK_SPECIALOFFERID
        , cast(ORDERQTY as int) as QUANTITY
        , cast(UNITPRICE as numeric(18,4)) as UNIT_PRICE
        , cast(UNITPRICEDISCOUNT as float) as UNITPRICEDISCOUNT
        from source
    )

select *
from remane_table