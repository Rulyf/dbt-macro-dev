 
{% macro ref(model_name, version=version, v=version, defer=true) -%}

    {# 
        This macro modifies the default behavior of the ref macro of dbt. The objective is 
        to create a  means to defer to certain models  that are built in different schemas, 
        for example, production models.

        When you defer a model to one previously built  you don't have to build them in your
        personal schema which saves time, resources and costs.

        The recommended way to use this macro is to choose models that are well mature from a
        development perspective,  in other words, don’t suffer changes too frequently and are 
        time and  resource intensive to  build. Some good candidates  are incremental staging
        models and intermediate models that have many children.
    #}

    {# Choose the targets that you want to have the defer option by creating a variable named defer_target_names #}
    {%- if target.name in var('defer_target_names', ()) -%}

        {%- if defer == true -%}

            {# Check if the model_name is one to be deffered. #}
            {%- if model_name in defer_models_list() -%} 

                {# Finnaly, we use the source_name and model_name defined in the sources.yml file. #}
                {{ return(builtins.source(defer_source_name(), model_name)) }}

            {%- else -%}
        
                {# If a model wasn't in the defer_models_list #}
                {{ return(builtins.ref(model_name, version=version)) }}
            
            {%- endif -%}

        {%- else -%}

            {# If defer == false #}
            {{ return(builtins.ref(model_name, version=version)) }}
            
        {%- endif -%}

    {%- else -%}

        {# If target name is not in the targets to defer list. #}
        {{ return(builtins.ref(model_name, version=version)) }}	

    {%- endif -%}

   
{%- endmacro %}
