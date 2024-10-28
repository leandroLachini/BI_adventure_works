/* Conexão com a fonte dos endereços de compra camada CIDADE */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'ADDRESS') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(ADDRESSID as int) as PK_ADDRESSID
        , cast(STATEPROVINCEID as int) as FK_STATEPROVINCEID
        , cast(CITY as varchar) as CITY
        from source
    )

select * from remane_table
