/* Conexão com a fonte dos endereços de compra camada ESTADOS */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'STATEPROVINCE') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(STATEPROVINCEID as int) as PK_STATEPROVINCEID
        , cast(COUNTRYREGIONCODE as varchar) as FK_COUNTRYREGIONCODE
        , cast(TERRITORYID as varchar) as FK_TERRITORYID
        , cast(NAME as varchar) as STATE_NAME
        from source
    )

select * from remane_table
