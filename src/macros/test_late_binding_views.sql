{% macro test_late_binding_view_in_dev() -%}

    {%- set is_late_binding_view=
        model['config']['materialized'] == 'view'
        and model['config']['bind'] == False
    -%}

    {%- set is_dev = (target.name != 'prod') -%}

    {%- if is_dev and is_late_binding_view -%}

        select * from {{ this }} limit 1

    {%- else -%}

        select 1 as test

    {%- endif -%}

{%- endmacro %}
