with 
    renamed as (
        select
            customerid as pk_customer
            , companyname as customer
            , contactname as customer_contact
            , city as customer_city
            , region as customer_region
            , country as customer_country
            /* Ignored columns for now */
            --contacttitle
            --postalcode
            -- phone
            -- fax
        from {{ source('erp', 'customers') }}
    )

select *
from renamed
