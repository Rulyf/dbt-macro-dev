{% macro defer_source_name(model_name) -%}

    {# Run macro only in execution mode #}
    {% if execute %}

        {% set source_name = namespace (holder = '') %}
        {# Iterate over all sources contained in graph.sources #}
        {% for sources in graph.sources.values() %} 
        {# Extract sources properties of the deffered model #}
            {%- if sources.name == model_name -%}
                {# Save the soure name to be used later on. #}
                {% set source_name.holder = sources.source_name|string %}
                {{ return(source_name.holder) }}
            {%- endif -%}
        {%- endfor %}
    
    {%- endif -%}

{%- endmacro %}
