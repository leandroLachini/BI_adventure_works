/* Source with staging produtc */

with
    product as (
        select
        *
        from {{ ref("stg_erp__PRODUCT")}}
    )

/* Source with staging productsubcategory */
    
    , product_subcategory as (
        select
        *
        from {{ ref("stg_erp__PRODUCTSUBCATEGORY")}}
    )

    /* Source with staging productcategory */
    
    , product_category as (
        select
        *
        from {{ ref("stg_erp__PRODUCTCATEGORY")}}
    )

/* Fazendo os joins subcategory and category */

    , joined_category as (
        select
        product_subcategory.PK_PRODUCTSUBCATEGORYID
        , product_subcategory.NAME_SUBCATEGORY_PRODUCT
        , product_category.NAME_CATEGORY_PRODUCT
        from product_subcategory
        left join product_category on product_category.PK_PRODUCTCATEGORYID = product_subcategory.FK_PRODUCTCATEGORYID
    )

/* Fazendo os joins para popular tabela com dados relevantes */

    , joined as (
        select
        product.PK_PRODUCTID
        , product.PRODUCT_NAME
        , product.PRODUCT_COLOR
        , product.PRODUCT_SIZE
        , product.PRODUCT_WEIGHT
        , coalesce(joined_category.NAME_SUBCATEGORY_PRODUCT, 'Unknown') as NAME_SUBCATEGORY_PRODUCT
        , coalesce(joined_category.NAME_CATEGORY_PRODUCT, 'Unknown') as NAME_CATEGORY_PRODUCT
        from product
        left join joined_category on joined_category.PK_PRODUCTSUBCATEGORYID = product.FK_PRODUCTSUBCATEGORYID
    )

select
*
from joined