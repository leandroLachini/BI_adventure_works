/* Conexão com a fonte dos endereços de compra camada PAIS */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'COUNTRYREGION') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(COUNTRYREGIONCODE as varchar) as PK_COUNTRYREGIONCODE
        , cast(NAME as varchar) as COUNTRY_NAME
        from source
    )

select * from remane_table
