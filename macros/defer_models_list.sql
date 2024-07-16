 {% macro defer_models_list() -%}

    {# 
        Choose the list of used target names in your project. If a user doesn't use the
        correct target name this macro will preventing him from running dbt commands. 
    #}
    {% if target.name not in ('prd', 'ci', 'dev') %}
        {{ 
            exceptions.raise_compiler_error(
                "Invalid target name. Got: " ~ target.name ~ ". Expected: dev.
                Change your target name or ask for assistance with a tech leader."
            ) 
        }}
    {% endif %}

    {# Run macro only in execution mode #}
    {% if execute %}
    
        {# Empty list to get all models set to be deffered. #}
        {% set models_list = [] -%}

        {# TBD #}
        {% for model in graph.nodes.values() | selectattr("resource_type", "equalto", "model") -%}

            {# 
                TBD
            #}
            {%- if model.meta.defer == true -%}
                
                {# Append models name to the list. #}
                {%- do models_list.append(model.name) -%}
                {# {{ log(sources.name, info=True) }} #}
            
            {%- endif -%}
        {%- endfor %}

        {# {{ log(models_list, info=True) }} #}
        {{ return(models_list) }}

    {%- else -%}

        {{ return([]) }}

    {%- endif -%}

{%- endmacro %}
