with 
    stg_products as (
        select *
        from {{ ref('stg_erp__products') }}
    )

    , stg_categories as (
        select *
        from {{ ref('stg_erp__categories') }}
    )

    , joined as (
        select
            products.pk_product
            , products.fk_supplier
            , products.unit_price
            , products.avaiable_stock
            , products.units_on_order
            , products.reorder_level
            , products.product
            , products.unit_quantity
            , categories.category
            , categories.category_desc
            , products.is_discontinued
        from stg_products as products
        left join stg_categories as categories
            on products.fk_category = categories.pk_category
    )

select *
from joined
