struct Mailjet
  struct Utilities
    def self.to_stringified_hash(value : Hash | NamedTuple)
      value.to_h.transform_keys(&.to_s).transform_values(&.to_s)
    end

    def self.to_camelcased_hash(value : Hash | NamedTuple)
      value.to_h.transform_keys(&.to_s.camelcase).transform_values do |v|
        to_camelcased_hash(v)
      end
    end

    def self.to_camelcased_hash(value : Array)
      value.map do |v|
        to_camelcased_hash(v)
      end
    end

    def self.to_camelcased_hash(value : Bool | Int32 | String?)
      value
    end

    def self.query_parameterize(value : Hash | NamedTuple) : String
      query = to_camelcased_hash(to_stringified_hash(value))
      HTTP::Params.encode(query)
    end
  end
end
