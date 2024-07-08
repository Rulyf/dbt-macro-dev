with 
    renamed as (
        select
            cast(productid as int) as pk_product
            , cast(supplierid as int) as fk_supplier
            , cast(categoryid as int) as fk_category
            , cast(unitprice as numeric) as unit_price
            , cast(unitsinstock as int) as avaiable_stock
            , cast(unitsonorder as int) as units_on_order
            , cast(reorderlevel as int) as reorder_level
            , productname as product
            , quantityperunit as unit_quantity
            , case
                when discontinued = '1' then true
                when discontinued = '0' then false
                else null
            end as is_discontinued
        from {{ source('erp', 'products') }}
    )

select *
from renamed
