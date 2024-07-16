{% macro full_object_name(model_name) -%}

    {# Run macro only in execution mode #}
    {% if execute %}

        {% set loc_full_name = namespace (holder = '') %}
        {# Iterate over all sources contained in graph.sources #}
        {% for model in graph.nodes.values() | selectattr("resource_type", "equalto", "model") -%}
        {# Extract sources properties of the deffered model #}
            {%- if model.name == model_name -%}
                {# Save the soure name to be used later on. #}
                {% set loc_full_name.holder = model.meta.defer_loc|string %}
                {{ return(loc_full_name.holder) }}
            {%- endif -%}
        {%- endfor %}
    
    {%- endif -%}

{%- endmacro %}
