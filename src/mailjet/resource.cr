struct Mailjet
  abstract struct Resource
    alias ResourceId = Int32 | Int64 | String

    macro can_list(pattern, mapping)
      {% unless mapping.id.stringify.starts_with?('{') %}
        {% mapping = {"Count": Int32, "Data": mapping, "Total": Int32} %}
      {% end %}

      def self.all(
        query : Hash | NamedTuple = Hash(String, String).new,
        params : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = ListPath.new(params).to_s
        response = client.handle_api_call("GET", path, query: query)

        ListResponse.from_json(response)
      end

      struct ListResponse
        include Mailjet::Json::Fields

        {% if mapping.keys.includes?("Data".id) %}
          forward_missing_to data
        {% end %}

        json_fields({{mapping}})
      end

      struct ListPath < Mailjet::Path
        getter pattern = {{pattern}}
      end
    end

    macro can_find(pattern, mapping)
      {% unless mapping.id.stringify.starts_with?('{') %}
        {% mapping = {"Data": mapping} %}
      {% end %}

      def self.find(
        params : Hash | NamedTuple = Hash(String, String).new,
        query : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = FindPath.new(params).to_s
        response = client.handle_api_call("GET", path, query: query)

        FindResponse.from_json(response)
          {% if mapping.keys.includes?("Data".id) %}.data.first{% end %}
      end

      def self.find(
        id : ResourceId,
        query : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        find({id: id}, query: query, client: client)
      end

      struct FindResponse
        include Mailjet::Json::Fields

        json_fields({{mapping}})
      end

      struct FindPath < Mailjet::Path
        getter pattern = {{pattern}}
      end
    end

    macro can_create(pattern, mapping)
      {% unless mapping.id.stringify.starts_with?('{') %}
        {% mapping = {"Data": mapping} %}
      {% end %}

      def self.create(
        payload : Hash | NamedTuple,
        params : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = CreatePath.new(params).to_s
        response = client.handle_api_call("POST", path,
          payload: Utilities.to_camelcased_hash(payload))

        CreateResponse.from_json(response)
          {% if mapping.keys.includes?("Data".id) %}.data.first{% end %}
      end

      struct CreateResponse
        include Mailjet::Json::Fields

        json_fields({{mapping}})
      end

      struct CreatePath < Mailjet::Path
        getter pattern = {{ pattern }}
      end
    end

    macro can_update(pattern, mapping)
      {% unless mapping.id.stringify.starts_with?('{') %}
        {% mapping = {"Data": mapping} %}
      {% end %}

      def self.update(
        params : Hash | NamedTuple = Hash(String, String).new,
        payload : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        path = UpdatePath.new(params).to_s
        response = client.handle_api_call("PUT", path,
          payload: Utilities.to_camelcased_hash(payload))

        unless response.empty?
          UpdateResponse.from_json(response)
            {% if mapping.keys.includes?("Data".id) %}.data.first{% end %}
        end
      end

      def self.update(
        id : ResourceId,
        payload : Hash | NamedTuple = Hash(String, String).new,
        client : Client = Client.new
      )
        update({id: id}, payload: payload, client: client)
      end

      struct UpdateResponse
        include Mailjet::Json::Fields

        json_fields({{mapping}})
      end

      struct UpdatePath < Mailjet::Path
        getter pattern = {{ pattern }}
      end
    end

    macro can_delete(pattern)
      def self.delete(
        id : ResourceId,
        client : Client = Client.new
      )
        path = DeletePath.new({id: id}).to_s
        client.handle_api_call("DELETE", path)
        nil
      end

      struct DeletePath < Mailjet::Path
        getter pattern = {{ pattern }}
      end
    end
  end
end
