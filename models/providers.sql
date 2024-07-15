{{
    config(materialized="table")
}}

with current_prefecture as (
    select
        provider_id,
        prefecture,
        case when
            dbt_valid_to is null then '2099-12-31'::timestamp
            else dbt_valid_to
        end as valid_to
    from {{ ref("providers_snapshot")}}
    qualify row_number() over (partition by provider_id order by valid_to desc) = 1
)

select
    base.*,
    base.prefecture as historical_prefecture,
    current.prefecture as current_prefecture,
    case when
        base.dbt_valid_to is null then 1
        else 0
    end as is_current
from {{ ref("providers_snapshot") }} as base
left join current_prefecture as current using (provider_id)
