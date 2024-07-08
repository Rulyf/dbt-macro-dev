with 
    renamed as (
        select
            {{ dbt_utils.generate_surrogate_key([
                    'orderid'
                    , 'productid'
                ]) 
            }} as sk_order_detail
            , cast(orderid as int) as fk_order
            , cast(productid as int) as fk_product
            , cast(unitprice as numeric) as unit_price
            , cast(quantity as int) as quantity
            , cast(discount as numeric) as discount
        from {{ source('erp', 'orders_details') }}
    )

select *
from renamed
