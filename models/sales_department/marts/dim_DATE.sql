/* Dimensao Data criada com clientes com base no artigo 
https://medium.com/indiciumtech/date-dimension-how-to-create-a-practical-and-useful-date-dimension-in-dbt-5ee70a18f3bb
*/

with 
     raw_generated_data as ( 
        {{ dbt_date.get_date_dimension('2011-05-31', '2014-07-01') }} 
    ) 

    , portuguese_renamed as ( 
        select 
             raw_generated_data. *
             , case 
                when raw_generated_data.day_of_week =  1  then 'Domingo' 
                when raw_generated_data.day_of_week =  2  then 'Segunda-feira' 
                when raw_generated_data.day_of_week =  3  then 'Terça-feira' 
                when raw_generated_data.day_of_week =  4  then 'Quarta-feira' 
                when raw_generated_data.day_of_week =  5  then 'Quinta-feira' 
                when raw_generated_data.day_of_week =  6  then 'Sexta-feira' 
                when raw_generated_data.day_of_week =  7  then 'Sábado' 
            end as day_of_week_name_pt 
        from raw_generated_data 
    ) 

select * from portuguese_renamed
