{% macro enforce_defer() %}

    {% if execute %}

        {{ log(selected_resources, info=True) }}
        
    {% endif %}

{% endmacro %}