select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select token
from "nca"."staging"."market"
where token is null



      
    ) dbt_internal_test