struct Mailjet
  struct Json
    module Fields
      macro included
        include JSON::Serializable
      end

      macro json_fields(mapping)
        {% for name, type in mapping %}
          {% underscored = name.underscore %}

          {% if type.id.starts_with?('{') %}
            @[JSON::Field(key: {{name.id}},
              converter: {{type[:converter].id}})]
            {% type = type[:type] %}
          {% elsif ["::Union(Time, ::Nil)".id].includes?(type.id) %}
            @[JSON::Field(key: {{name.id}},
              converter: Mailjet::Json::NilableTime)]
          {% else %}
            @[JSON::Field(key: {{name.id}})]
          {% end %}

          getter {{underscored.id}} : {{type}}
        {% end %}
      end
    end
  end
end
