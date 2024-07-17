{% macro check_select_arg() %}

    {# Prevent user from executing full build/run of dbt models. #}
    {% if 
        not invocation_args_dict.select 
        and target.name not in ('prd', 'ci') 
        and invocation_args_dict.which in ('run', 'build')
    %}

        {{ exceptions.raise_compiler_error(
            "Error: You must provide at least one select argument."
        ) }}

    {% endif %}

{% endmacro %}