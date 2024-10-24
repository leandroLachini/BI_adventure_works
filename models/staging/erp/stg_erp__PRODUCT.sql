/* Conexão com a fonte de produtos */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'PRODUCT') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(PRODUCTID as int) as PK_PRODUCTID
        , cast(SIZEUNITMEASURECODE as varchar) as FK_SIZEUNITMEASURECODE
        , cast(WEIGHTUNITMEASURECODE as varchar) as FK_WEIGHTUNITMEASURECODE
        , cast(PRODUCTSUBCATEGORYID as int) as FK_PRODUCTSUBCATEGORYID
        , cast(PRODUCTMODELID as int) as FK_PRODUCTMODELID
        , cast(SELLSTARTDATE as date) as SELLSTARTDATE
        , cast(SELLENDDATE as date) as SELLENDDATE
        , cast(NAME as varchar) as PRODUCT_NAME 
        --, cast(MAKEFLAG as int) as
        --, cast(FINISHEDGOODSFLAG as int) as
        , cast(COLOR as varchar) as PRODUCT_COLOR
        , cast(SAFETYSTOCKLEVEL as int) as SAFETYSTOCK
        , cast(REORDERPOINT as int) as REORDERPOINT
        , cast(STANDARDCOST as float) as STANDARDCOST
        , cast(LISTPRICE as float) as LISTPRICE
        , cast(SIZE as varchar) as PRODUCT_SIZE
        , cast(WEIGHT as int) as PRODUCT_WEIGHT
        --, cast(DAYSTOMANUFACTURE as varchar) as
        , cast(PRODUCTLINE as varchar) as PRODUCTLINE
        , cast(CLASS as varchar) as CLASS
        , cast(STYLE as varchar) as STYLE
        from source
    )

select *
from remane_table