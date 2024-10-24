/* Conexão com a fonte de pagamentos */

with
    source as (
        select
        *
        from {{ source('erp_adventure_works', 'CREDITCARD') }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(CREDITCARDID as int) as PK_CREDITCARDID
        , cast(CARDTYPE as varchar) as CARDTYPE
        from source
    )

select * from remane_table
