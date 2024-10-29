/* Dimensao produtos */

with
    staging as (
        select
        PK_PRODUCTID
        , SELLSTARTDATE        
        , SELLENDDATE
        , PRODUCT_NAME
        , PRODUCT_COLOR
        , SAFETYSTOCK
        , REORDERPOINT
        , STANDARDCOST
        , LISTPRICE
        , PRODUCT_SIZE
        , PRODUCT_WEIGHT
        from {{ ref("stg_erp__PRODUCT")}}
    )

select * from staging
