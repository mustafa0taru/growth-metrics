select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      





with validation_errors as (

    select
        date, token
    from "nca"."staging"."market"
    group by date, token
    having count(*) > 1

)

select *
from validation_errors



      
    ) dbt_internal_test