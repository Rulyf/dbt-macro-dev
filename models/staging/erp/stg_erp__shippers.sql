with 
    renamed as (
        select
            cast(shipperid as int) as pk_shipper
            , companyname as shipper
            /* Ignored columns for now */
            -- phone
        from {{ source('erp', 'shippers') }}
    )

select *
from renamed
