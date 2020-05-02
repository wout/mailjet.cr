struct Mailjet
  struct Utilities
    def self.to_stringified_hash(value : Hash | NamedTuple) : Hash(String, String)
      value.to_h.transform_keys(&.to_s).transform_values(&.to_s)
    end

    def self.to_camelcased_hash(value : Hash | NamedTuple)
      value.to_h.transform_keys(&.to_s.camelcase)
    end

    def self.query_parameterize(value : Hash | NamedTuple) : String
      query = to_camelcased_hash(to_stringified_hash(value))
      HTTP::Params.encode(query)
    end
  end
end
