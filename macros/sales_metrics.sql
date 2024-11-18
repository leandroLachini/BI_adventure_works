{% macro gross_income(column_1, column_2) %}
    ({{ column_1 }} * {{ column_2 }})::numeric(16, 4)
{% endmacro %}

{% macro net_value(column_1, column_2, column_3) %}
    ({{column_1}} * {{column_2}} * (1 - {{column_3}}))::numeric(16, 4)
{% endmacro %}

{% macro prorated(column_name) %}
    (count(*) over(partition by {{column_name}}))
{% endmacro %}