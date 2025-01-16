select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select referrer_user_id
from "nca"."staging"."referrals"
where referrer_user_id is null



      
    ) dbt_internal_test