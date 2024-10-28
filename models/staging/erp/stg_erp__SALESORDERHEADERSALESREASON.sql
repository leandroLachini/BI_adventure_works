/* Conexão com a fonte CHAVE dos motivos de compra */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'SALESORDERHEADERSALESREASON') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(SALESORDERID as int) as PK_SALESORDERID
        , cast(SALESREASONID as int) as FK_SALESREASONID
        from source
    )

select *
from remane_table