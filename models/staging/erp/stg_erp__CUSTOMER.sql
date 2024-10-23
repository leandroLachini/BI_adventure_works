/* Conexão com a fonte dos clientes */

with
    source_customer as (
        select
        *
        from {{ source('erp_adventure_works', 'CUSTOMER') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(CUSTOMERID as int) as PK_CUSTOMERID
        , cast(STOREID as int) as FK_STOREID
        , cast(TERRITORYID as int) as FK_TERRITORYID
        from source_customer
    )

select *
from remane_table