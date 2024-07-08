with 
    stg_orders_details as (
        select *
        from {{ ref('stg_erp__orders_details') }}
    )

    , stg_orders as (
        select *
        from {{ ref('stg_erp__orders') }}
    )

    , joined as (
        select
            details.sk_order_detail
            , orders.fk_customer
            , details.fk_product
            , orders.fk_employee
            , orders.fk_shipper
            , orders.order_dt
            , orders.required_dt
            , orders.shipped_dt
            , details.unit_price
            , details.quantity
            , details.discount
            , orders.freight
            , details.fk_order as invoice_number
            , orders.customer
            , orders.customer_city
            , orders.customer_region
            , orders.customer_country
        from stg_orders_details as details
        left join stg_orders as orders
            on details.fk_order = orders.pk_order
    )

    , metrics as (
        select
            sk_order_detail
            , fk_customer
            , fk_product
            , fk_employee
            , fk_shipper
            , order_dt
            , required_dt
            , shipped_dt
            , unit_price
            , quantity
            , discount
            , unit_price * quantity as gross_amount
            , unit_price * (1 - discount) as discount_amount
            /* Freight rated by itens in an invoice. */
            , round(
                freight / count(*) over (partition by invoice_number)
            , 2) as prorated_freight_amount
            /* Net amount = Gross amount minus discount and freight. */
            , round(
                (unit_price * quantity) 
                - (unit_price * (1 - discount)) 
                - (freight / count(*) over (partition by invoice_number))
            , 2) as net_amount
            , invoice_number
            , customer
            , customer_city
            , customer_region
            , customer_country
            , case
                when date_diff(required_dt, shipped_dt, day) >= 2 then false
                else true
            end as is_delayed
        from joined
    )

select *
from metrics
