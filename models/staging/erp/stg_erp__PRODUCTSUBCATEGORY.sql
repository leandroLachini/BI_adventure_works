/* connection with product subcategory source.*/

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'PRODUCTSUBCATEGORY') }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(PRODUCTSUBCATEGORYID as int) as PK_PRODUCTSUBCATEGORYID
        , cast(PRODUCTCATEGORYID as int) as FK_PRODUCTCATEGORYID
        , cast(NAME as varchar) as NAME_SUBCATEGORY_PRODUCT
        from source
    )

select *
from remane_table