{% snapshot providers_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='provider_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

-- select * from {{ ref('stg_providers') }}
select * from {{ ref("stg_providers_update") }}

{% endsnapshot %}
