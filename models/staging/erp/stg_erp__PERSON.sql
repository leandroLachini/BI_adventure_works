/* Conexão com a fonte das pessoas cadastradas */

with
    source_person as (
        select
        *
        from {{ source("erp_adventure_works", "PERSON") }}
    )

/* Renomeando colunas da tabela e categorizando os dados */

    , remane_table as (
        select
        cast(BUSINESSENTITYID as int) as PK_PERSONID
        , FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME as PERSON_FULL_NAME
        from source_person
    )

select
*
from remane_table