{% macro gross_income(column_1, column_2) %}
    ({{ column_1 }} * {{ column_2 }})::numeric(16, 4) as GROSS_VALUE
{% endmacro %}

{% macro net_value(column_1, column_2, column_3) %}
    ({{column_1}} * {{column_2}} * (1 - {{column_3}}))::numeric(16, 4) as NET_VALUE
{% endmacro %}
