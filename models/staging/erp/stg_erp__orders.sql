with 
    renamed as (
        select
            cast(orderid as int) as pk_order
            , customerid as fk_customer
            , cast(employeeid as int) as fk_employee
            , cast(shipvia as int) as fk_shipper
            , cast(orderdate as date) order_dt
            , cast(requireddate as date) required_dt
            , cast(shippeddate as date) shipped_dt
            , cast(freight as numeric) as freight
            , shipname as customer
            , shipcity as customer_city
            , shipregion as customer_region
            , shipcountry as customer_country
            /* Ignored columns for now */
            -- shippostalcode
        from {{ source('erp', 'orders') }}
    )

select *
from renamed
