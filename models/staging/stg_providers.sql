{{
    config(
        materialized='table',
    )
}}
select
    provider_id,
    provider_name,
    provider_type,
    prefecture,
    now() as updated_at
from {{ ref("providers") }}
