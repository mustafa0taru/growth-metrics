select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select daily_volume
from "nca"."staging"."market"
where daily_volume is null



      
    ) dbt_internal_test