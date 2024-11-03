/* Conexão com a fonte dos productsubcategory */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'PRODUCTSUBCATEGORY') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(PRODUCTSUBCATEGORYID as int) as PK_PRODUCTSUBCATEGORYID
        , cast(PRODUCTCATEGORYID as int) as FK_PRODUCTCATEGORYID
        , cast(NAME as varchar) as NAME_SUBCATEGORY_PRODUCT
        from source
    )

select *
from remane_table