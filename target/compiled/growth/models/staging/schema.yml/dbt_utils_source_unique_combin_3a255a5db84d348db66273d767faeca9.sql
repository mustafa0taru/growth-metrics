





with validation_errors as (

    select
        date, token
    from "nca"."staging"."market"
    group by date, token
    having count(*) > 1

)

select *
from validation_errors


