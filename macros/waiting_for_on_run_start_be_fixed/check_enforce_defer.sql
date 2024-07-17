{% macro check_enforce_defer(model_name) %}
    
    {% if execute %}

        {# Prevent user from executing full build/run of dbt models. #}
        {% if "model.dbt_northwind_demo." ~ model_name in selected_resources %}

            {{ exceptions.raise_compiler_error(
                "Error: Add: --exclude " ~ model_name ~ ". To your dbt command. Defer for production models is automatic."
            ) }}

        {% endif %}

    {% endif %}

{% endmacro %}