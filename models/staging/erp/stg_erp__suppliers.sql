with 
    renamed as (
        select
            cast(supplierid as int) as pk_supplier
            , companyname as supplier
            , city as supplier_city
            , country as supplier_country
            /* Ignored columns for now */
            -- contactname
            -- contacttitle
            -- address
            -- region
            -- postalcode
            -- phone
            -- fax
            -- homepage
        from {{ source('erp', 'suppliers') }}
    )

select *
from renamed
