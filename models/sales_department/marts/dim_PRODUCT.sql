/* Dimensao produtos */

with
    int_product as (
        select
        PK_PRODUCTID
        , STANDARDCOST
        , LISTPRICE
        , PRODUCT_MARGIN
        , PRODUCT_NAME
        , PRODUCT_COLOR
        , PRODUCT_SIZE
        , PRODUCT_WEIGHT
        , NAME_SUBCATEGORY_PRODUCT
        , NAME_CATEGORY_PRODUCT
        from {{ ref("int_product_joins")}}
    )

select * from int_product
