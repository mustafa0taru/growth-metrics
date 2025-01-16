

with validation as (
    select
        amount as value_to_check
    from "nca"."staging"."transactions"
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

