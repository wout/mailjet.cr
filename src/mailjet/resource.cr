struct Mailjet
  abstract struct Resource
    macro can_list(pattern, mapping = nil)
      def self.all(
        query : Hash | NamedTuple = Hash(String, String).new,
        params : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = ListPath.new(params).to_s
        response = client.handle_api_call("GET", path, query: query)
        {% if mapping %}
          ListResponse.from_json(response)
        {% else %}
          true
        {% end %}
      end

      {% if mapping %}
        struct ListResponse
          include Json::Fields

          json_fields({{mapping}})
        end
      {% end %}

      struct ListPath < Mailjet::Path
        getter pattern = {{pattern}}
      end
    end

    macro can_find(pattern, mapping = nil)
      def self.find(
        params : Hash | NamedTuple = Hash(String, String).new,
        query : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = FindPath.new(params).to_s
        response = client.handle_api_call("GET", path, query: query)

        {% if mapping %}
          FindResponse.from_json(response)
            {% if mapping.keys.includes?("Data".id) %}.data.first{% end %}
        {% else %}
          true
        {% end %}
      end

      {% if mapping %}
        struct FindResponse
          include Json::Fields

          json_fields({{mapping}})
        end
      {% end %}

      struct FindPath < Mailjet::Path
        getter pattern = {{pattern}}
      end
    end

    macro can_create(pattern, mapping = nil)
      def self.create(
        payload : Hash | NamedTuple,
        params : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = CreatePath.new(params).to_s
        response = client.handle_api_call("POST", path,
          payload: Utilities.to_camelcased_hash(payload))

        {% if mapping %}
          CreateResponse.from_json(response)
            {% if mapping.keys.includes?("Data".id) %}.data.first{% end %}
        {% else %}
          true
        {% end %}
      end

      {% if mapping %}
        struct CreateResponse
          include Json::Fields

          json_fields({{mapping}})
        end
      {% end %}

      struct CreatePath < Mailjet::Path
        getter pattern = {{ pattern }}
      end
    end
  end
end
