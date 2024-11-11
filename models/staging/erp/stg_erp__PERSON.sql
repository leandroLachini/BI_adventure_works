/* connection with person source.*/

with
    source as (
        select
        *
        from {{ source("erp_adventure_works", "PERSON") }}
    )

/* renaming table columns and categorizing data */

    , remane_table as (
        select
        cast(BUSINESSENTITYID as int) as PK_PERSONID
        , FIRSTNAME || ' ' || MIDDLENAME || ' ' || LASTNAME as PERSON_FULL_NAME
        from source
    )

select
*
from remane_table