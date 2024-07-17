{% macro source(source_name, table_name) -%}

    {# 
        It's possible to prevent user from running dbt run or dbt build
        without  selectors by applying a check in sources  during parse.
        This is a workaround, because on-hook-start doesn't work.
    #}
    {{ check_select_arg() }}

    {{ return(builtins.source(source_name, table_name)) }}

{%- endmacro %}