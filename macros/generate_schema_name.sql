{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {# In prd environment show only custom schema name #}
    {%- if target.name == 'prd' and custom_schema_name is not none -%}

        {{ custom_schema_name | trim }}

    {%- else -%}

        {%- if custom_schema_name is none -%}

            {{ default_schema }}
        {# 
            Through the seeds create a schema that simulates
            the northwind raw data acquired by an EL process
        #}
        {%- elif custom_schema_name == 'northwind_erp' -%}

            {{ custom_schema_name | trim }}

        {%- else -%}

            {{ default_schema }}_{{ custom_schema_name | trim }}

        {%- endif -%}
    
    {%- endif -%}

{%- endmacro %}