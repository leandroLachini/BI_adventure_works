/* Dimension Customer */

with
    int_customer as (
        select
        PK_CUSTOMERID
        , PK_PERSONID
        , FK_STOREID
        , FK_TERRITORYID
        , PERSON_FULL_NAME
        from {{ ref('int_customer_joins') }}
    )

select
*
from int_customer
