/* conection with staging ADDRESS */

with
    address as (
        select
        *
        from {{ ref("stg_erp__ADDRESS")}}
    )

/* conection with staging SATEPROVINCE */
    
    , state_province as (
        select
        *
        from {{ ref("stg_erp__STATEPROVINCE")}}
    )

/* conection with staging COUNTRYREGION */
    
    , country_region as (
        select
        *
        from {{ ref("stg_erp__COUNTRYREGION")}}
    )

/* making joins to populate a table with relevant data */

    , joined as (
        select
        address.PK_ADDRESSID
        , address.CITY
        , state_province.STATE_NAME
        , country_region.COUNTRY_NAME

        from address
        left join state_province on state_province.PK_STATEPROVINCEID = address.FK_STATEPROVINCEID
        left join country_region on country_region.PK_COUNTRYREGIONCODE = state_province.FK_COUNTRYREGIONCODE
    )

select * from joined
