with
    int_employees as (
        select *
        from {{ ref('int_sales__employees') }}
    )

select *
from int_employees

