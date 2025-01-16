{% test positive_value(model, column_name) %}

with validation as (
    select
        {{ column_name }} as value_to_check
    from {{ model }}
),

validation_errors as (
    select
        value_to_check
    from validation
    where value_to_check <= 0
        or value_to_check is null
)

select *
from validation_errors

{% endtest %}