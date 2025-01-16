





with validation_errors as (

    select
        referred_user_id
    from "nca"."staging"."referrals"
    group by referred_user_id
    having count(*) > 1

)

select *
from validation_errors


