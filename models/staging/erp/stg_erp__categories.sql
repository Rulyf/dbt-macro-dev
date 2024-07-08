with 
    renamed as (
        select
            cast(categoryid as int) as pk_category
            , categoryname as category
            , description as category_desc
            /* Ignored columns for now */
            -- picture
        from {{ source('erp', 'categories') }}
    )

select *
from renamed
