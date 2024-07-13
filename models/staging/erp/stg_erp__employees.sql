with 
    renamed as (
        select
            cast(employeeid as int) as pk_employee
            , cast(reportsto as int) as fk_manager
            , cast(birthdate as date) employee_birth_dt
            , cast(hiredate as date) employee_hire_dt
            , firstname || ' ' || lastname as employee
            , title as employee_role
            , city as employee_city
            , country as employee_country
            , notes as employee_desc
            /* Ignored columns for now */
            -- address
            -- region
            -- postalcode
            -- titleofcourtesy
            -- homephone
            -- extension
            -- photo
            -- photopath
        from {{ source('erp', 'employees') }}
    )

select *
from renamed
