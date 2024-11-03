/* Conexão com a fonte dos productcategory */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'PRODUCTCATEGORY') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(PRODUCTCATEGORYID as int) as PK_PRODUCTCATEGORYID
        , cast(NAME as varchar) as NAME_CATEGORY_PRODUCT
        from source
    )

select *
from remane_table