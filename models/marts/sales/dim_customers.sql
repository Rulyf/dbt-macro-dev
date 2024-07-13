with 
    stg_customers as (
        select *
        from {{ ref('stg_erp__customers') }}
    )

select *
from stg_customers
