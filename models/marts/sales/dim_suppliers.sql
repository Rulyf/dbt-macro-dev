with 
    stg_suppliers as (
        select *
        from {{ ref('stg_erp__suppliers') }}
    )

select *
from stg_suppliers
