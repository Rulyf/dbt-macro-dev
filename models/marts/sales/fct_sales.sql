with
    orders_details as (
        select *
        from {{ ref('int_sales__orders_detailed') }}
    )
    
    , customers as (
        select *
        from {{ ref('dim_customers') }}
    )

    , products as (
        select *
        from {{ ref('dim_products') }}
    )

    , employees as (
        select *
        from {{ ref('dim_employees') }}
    )

    , shippers as (
        select *
        from {{ ref('dim_shippers') }}
    )

    , suppliers as (
        select *
        from {{ ref('dim_suppliers') }}
    )

    , joined as (
        select
            orders_details.sk_order_detail as sk_sales
            , orders_details.fk_customer
            , orders_details.fk_product
            , orders_details.fk_employee
            , orders_details.fk_shipper
            , products.fk_supplier           
            , orders_details.order_dt
            , orders_details.required_dt
            , orders_details.shipped_dt
            , orders_details.unit_price
            , orders_details.quantity
            , orders_details.discount
            , orders_details.gross_amount
            , orders_details.discount_amount
            , orders_details.prorated_freight_amount
            , orders_details.net_amount
            , orders_details.invoice_number
            , orders_details.customer
            , orders_details.customer_city
            , orders_details.customer_region
            , orders_details.customer_country
            , orders_details.is_delayed
        from orders_details
        left join products
            on orders_details.fk_product = products.pk_product
    )

select *
from joined
