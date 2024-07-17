{% macro check_correct_target_name() %}

    {# 
        Choose the list of used target names in your project. If a user doesn't use the
        correct target name this macro will preventing him from running dbt commands. 
    #}
    {% if target.name not in ('prd', 'ci', 'dev') %}

        {{ exceptions.raise_compiler_error(
            "Error: Invalid target name. Got: " ~ target.name ~ ". Expected: dev.
            Change your target name or ask for assistance with a tech leader."
        ) }}
        
    {% endif %}

{% endmacro %}