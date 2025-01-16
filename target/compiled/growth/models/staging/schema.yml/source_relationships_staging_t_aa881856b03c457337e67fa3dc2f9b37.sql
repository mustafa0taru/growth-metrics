
    
    

with child as (
    select token as from_field
    from "nca"."staging"."transactions"
    where token is not null
),

parent as (
    select token as to_field
    from "nca"."staging"."market"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


