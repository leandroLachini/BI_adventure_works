/* conection with staging customer */

with
    customer as (
        select
        *
        from {{ ref("stg_erp__CUSTOMER")}}
    )

/* conection with staging person */
    
    , person as (
        select
        *
        from {{ ref("stg_erp__PERSON")}}
    )

/* making joins to populate a table with relevant data */

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

select * from joined