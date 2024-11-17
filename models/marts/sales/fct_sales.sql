with
    int_sales as (
        select *
        from {{ ref('int_sales__orders_detailed') }}
    )

select *
from int_sales
