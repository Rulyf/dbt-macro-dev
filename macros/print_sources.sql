{% macro print_sources() %}

    {# Run macro only in execution mode #}
    {% if execute %}

        {# Iterate over all sources contained in graph.sources #}
        {% for sources in graph.sources.values() %}

            {# Extract sources properties #}
            {% set source_name = sources.source_name %}
            {% set table_name = sources.name %}

            {%- if sources.name in ('dim_customers', 'stg_erp__products')  -%}

                {# Print sources properties to console #}  
                {{ log(source_name ~ '.' ~ table_name, info=True) }}
            
            {% endif %}

        {% endfor %}

    {% endif %}

{% endmacro %}
