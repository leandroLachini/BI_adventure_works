/* Conexão com a fonte dos motivos de compra */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'SALESREASON') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(SALESREASONID as int) as PK_SALESREASONID
        ,cast(NAME as varchar) as NAME_SALESREASON
        ,cast(REASONTYPE as varchar) as TYPE_SALESREASON
        from source
    )

select * from remane_table
