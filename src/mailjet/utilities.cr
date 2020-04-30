struct Mailjet
  struct Utilities
    def self.to_stringified_hash(value : Hash | NamedTuple) : Hash(String, String)
      value.to_h.transform_keys(&.to_s).transform_values(&.to_s)
    end

    def self.query_parameterize(value : Hash | NamedTuple) : String
      query = to_stringified_hash(value).transform_keys(&.camelcase)
      HTTP::Params.encode(query)
    end
  end
end
