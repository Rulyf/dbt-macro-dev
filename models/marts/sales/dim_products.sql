with
    int_products as (
        select *
        from {{ ref('int_sales__products') }}
    )

select *
from int_products
