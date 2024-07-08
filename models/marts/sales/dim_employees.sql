with 
    stg_employees as (
        select *
        from {{ ref('stg_erp__employees') }}
    )

    , managers_joined as (
        select
            employees.pk_employee
            , employees.employee_birth_dt
            , employees.employee_hire_dt
            , employees.employee
            , employees.employee_role
            , managers.employee as manager
            , employees.employee_city
            , employees.employee_country
            , employees.employee_desc
        from stg_employees as employees
        left join stg_employees as managers
            on employees.fk_manager = managers.pk_employee
    )

select *
from managers_joined
