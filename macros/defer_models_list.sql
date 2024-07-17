 {% macro defer_models_list() -%}

    {# Run macro only in execution mode #}
    {% if execute %}
    
        {# Empty list to get all models set to be deffered. #}
        {% set models_list = [] -%}

        {# Iterate over all models in the project. #}
        {% for model in graph.nodes.values() | selectattr("resource_type", "equalto", "model") -%}

            {# Find models with the defer config. #}
            {%- if model.meta.defer == true -%}
                
                {# Append models name to the list. #}
                {%- do models_list.append(model.name) -%}
            
            {%- endif -%}

        {%- endfor %}

        {{ return(models_list) }}

    {%- else -%}

        {{ return([]) }}

    {%- endif -%}

{%- endmacro %}
