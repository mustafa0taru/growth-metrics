select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select referral_date
from "nca"."staging"."referrals"
where referral_date is null



      
    ) dbt_internal_test