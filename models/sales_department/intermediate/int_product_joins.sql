/* conection with staging produtc */

with
    product as (
        select
        *
        from {{ ref("stg_erp__PRODUCT")}}
    )

/* conection with staging productsubcategory */
    
    , product_subcategory as (
        select
        *
        from {{ ref("stg_erp__PRODUCTSUBCATEGORY")}}
    )

/* conection with staging productcategory */
    
    , product_category as (
        select
        *
        from {{ ref("stg_erp__PRODUCTCATEGORY")}}
    )

/* making joins to populate a table with relevant data */

    , joined_category as (
        select
        product_subcategory.PK_PRODUCTSUBCATEGORYID
        , product_subcategory.NAME_SUBCATEGORY_PRODUCT
        , product_category.NAME_CATEGORY_PRODUCT
        from product_subcategory
        left join product_category on product_category.PK_PRODUCTCATEGORYID = product_subcategory.FK_PRODUCTCATEGORYID
    )

/* making joins to populate a table with relevant data */

    , joined as (
        select
        product.PK_PRODUCTID
        , product.STANDARDCOST
        , product.LISTPRICE
        , product.PRODUCT_NAME
        , product.PRODUCT_COLOR
        , product.PRODUCT_SIZE
        , product.PRODUCT_WEIGHT
        , coalesce(joined_category.NAME_SUBCATEGORY_PRODUCT, 'Unknown') as NAME_SUBCATEGORY_PRODUCT
        , coalesce(joined_category.NAME_CATEGORY_PRODUCT, 'Unknown') as NAME_CATEGORY_PRODUCT
        from product
        left join joined_category on joined_category.PK_PRODUCTSUBCATEGORYID = product.FK_PRODUCTSUBCATEGORYID
    )

/* generating metrics for analysis */
    , metrics as (
        select 
            joined. *
            , LISTPRICE - STANDARDCOST as PRODUCT_MARGIN
        from joined
    )

/* final format of the table with metrics */
    , final_table as (
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
        from metrics
    )

select * from final_table
