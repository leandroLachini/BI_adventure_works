/* Dimension Status */

with
    seed as (
        select
        STATUSID
        , NAME_STATUS
        from {{ref("seed_status_name")}}
    )

select * from seed
