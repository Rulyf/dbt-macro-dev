{% macro source_sample_dbk(source_name, table_name, sample_size=25) -%}

    {#
        Choose the list of used target names in your project. If a user doesn't use the
        correct target name this macro will prevent him from running dbt commands. Use
        this block if you want to enforce developers to use the source sampling feature.
    #}
    {% if target.name not in ('prd', 'ci', 'dev', 'default') %}
        {{
            exceptions.raise_compiler_error(
                "Invalid target name detected: " ~ target.name ~ ". Expected: dev. Change your target name or contact your tech leader for assistance."
            )
        }}
    {% endif %}

    {%- if target.name in var('sample_target_list', ()) and table_name in var('sample_source_list', ()) -%}

        {{ return(builtins.source(source_name, table_name) ~ " tablesample (" ~ sample_size ~ " percent)") }}
    
    {%- else -%}
   
        {{ return(builtins.source(source_name, table_name)) }}
   
    {%- endif -%}

{%- endmacro %}