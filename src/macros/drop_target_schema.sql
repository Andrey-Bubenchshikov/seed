{% macro drop_target_schema() %}
  {% set query %}
  drop schema if exists {{ target.schema }} cascade
  {% endset %}

  {% do run_query(query) %}
  {{ log("dropped schema: " ~ target.schema, info = true) }}
{% endmacro %}
