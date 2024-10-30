/* Dimensao Data criada com clientes com base no artigo 
https://medium.com/indiciumtech/date-dimension-how-to-create-a-practical-and-useful-date-dimension-in-dbt-5ee70a18f3bb
*/

with 
     raw_generated_data as ( 
        {{ dbt_date.get_date_dimension('2011-05-31', '2014-07-01') }} 
    ) 

    , id_year_month as ( 
        select 
             raw_generated_data. *
            , MONTH_NAME_SHORT || '-' || YEAR_NUMBER as MONTH_YEAR
            , cast(YEAR_NUMBER || MONTH_OF_YEAR as numeric(20,0)) as YEAR_MONTH
        from raw_generated_data 
    ) 

select * from id_year_month
