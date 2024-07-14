 {% macro defer_models_list() -%}

    {# 
        Choose the list of used target names in your project. If a user doesn't use the
        correct target name this macro will preventing him from running dbt commands. 
    #}
    {% if target.name not in ('prd', 'ci', 'uat', 'developer', 'default') %}
        {{ 
            exceptions.raise_compiler_error(
                "Invalid target name. Got: " ~ target.name ~ ". Expected: developer.
                Change your target name or ask for assistance with a tech leader."
            ) 
        }}
    {% endif %}

    {# Run macro only in execution mode #}
    {% if execute %}
    
        {# Empty list to get all models set to be deffered. #}
        {% set models_list = [] -%}
        {# Iterate over all sources contained in graph.sources #}
        {% for sources in graph.sources.values() -%}
            {# 
                Don't forget to create a source.yml file with  the models you chose to defer and
                a defer_names variable  in your project_yml with the source names defined in the
                source.yml file you just created. If you don't add the variable nothing is going
                to happend. It will default to an empty list ().
            #}
            {%- if sources.source_name in var('defer_source_names', ()) -%}
                {# Append models name to the list. #}
                {%- do models_list.append(sources.name) -%}
                {# {{ log(sources.name, info=True) }} #}
            {%- endif -%}
        {%- endfor %}

        {# {{ log(models_list, info=True) }} #}
        {{ return(models_list) }}

    {%- else -%}

        {{ return([]) }}

    {%- endif -%}

{%- endmacro %}
