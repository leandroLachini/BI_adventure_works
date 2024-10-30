/* Conexao com a staging clientes */

with
    customer as (
        select
        *
        from {{ ref("stg_erp__CUSTOMER")}}
    )

/* Conexao com a staging pessoas */
    
    , person as (
        select
        *
        from {{ ref("stg_erp__PERSON")}}
    )

/* Fazendo os joins para popular tabela com dados relevantes */

    , joined as (
        select
        customer.PK_CUSTOMERID
        , person.PK_PERSONID
        , customer.FK_STOREID
        , customer.FK_TERRITORYID
        , coalesce(person.PERSON_FULL_NAME, 'Unknown') as PERSON_FULL_NAME
        from customer
        left join person on person.PK_PERSONID = customer.FK_PERSONID
    )
select
*
from joined