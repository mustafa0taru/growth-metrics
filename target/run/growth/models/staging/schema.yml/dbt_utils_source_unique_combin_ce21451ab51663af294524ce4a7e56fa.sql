select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      





with validation_errors as (

    select
        referred_user_id
    from "nca"."staging"."referrals"
    group by referred_user_id
    having count(*) > 1

)

select *
from validation_errors



      
    ) dbt_internal_test