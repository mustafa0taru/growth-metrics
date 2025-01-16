
    
    

select
    referral_code as unique_field,
    count(*) as n_records

from (select * from "nca"."staging"."users" where referral_code is not null) dbt_subquery
where referral_code is not null
group by referral_code
having count(*) > 1


