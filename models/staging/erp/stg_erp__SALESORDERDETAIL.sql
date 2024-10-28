/* Conexão com a fonte dos pedidos vendidos detalhados */ 

with
    source as (
        select 
        *
        from {{ source('erp_adventure_works', 'SALESORDERDETAIL') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        md5(SALESORDERID) as SK_SALESORDERDETAIL
        , cast(SALESORDERID as int) as FK_SALESORDERID
        , cast(SALESORDERDETAILID as int) as PK_ORDERDETAILID
        , cast(PRODUCTID as int) as FK_PRODUCTID
        , cast(SPECIALOFFERID as int) as FK_SPECIALOFFERID
        , cast(ORDERQTY as int) as QUANTITY
        , cast(UNITPRICE as numeric(18,2)) as UNIT_PRICE
        , cast(UNITPRICEDISCOUNT as float) as UNITPRICEDISCOUNT
        from source
    )

select *
from remane_table