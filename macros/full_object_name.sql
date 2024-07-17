{% macro full_object_name(model_name) -%}

    {# Run macro only in execution mode #}
    {% if execute %}

        {% set full_obj_name = namespace (holder = '') %}
        
        {# Iterate over all models contained in graph.nodes #}
        {% for model in graph.nodes.values() | selectattr("resource_type", "equalto", "model") -%}
            
            {# Select the model from the graph that is currently parsing. #}
            {%- if model.name == model_name -%}
                
                {# Save the full object name to be used later on. #}
                {% set full_obj_name.holder = model.meta.defer_loc|string %}
                {{ return(full_obj_name.holder) }}

            {%- endif -%}

        {%- endfor %}
    
    {%- endif -%}

{%- endmacro %}
