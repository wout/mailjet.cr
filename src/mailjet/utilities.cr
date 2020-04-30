struct Mailjet
  struct Utilities
    def self.normalize_hash(value : Hash | NamedTuple)
      value.to_h.transform_keys(&.to_s)
    end
  end
end
