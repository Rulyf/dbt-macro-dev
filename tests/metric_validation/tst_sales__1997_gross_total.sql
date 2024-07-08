/* 
    Sales team pointed out that the sales audit of the 1997 found out that U$ 658388.75 was sold.
    This test guarantees that our pipeline reaches the same value on every run.
*/
with
    gross_total_1997 as (
        select 
            extract(year from order_dt) as year_sale
            , sum(gross_amount) as gross_total
        from {{ ref('fct_sales') }}
        where extract(year from order_dt) = 1997
        group by year_sale
    )

select *
from gross_total_1997
where gross_total not between 658388.70 and 658388.80
