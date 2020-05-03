struct Mailjet
  struct Json
    struct NilableTime
      def self.from_json(value : JSON::PullParser)
        if value.kind.string? && !(time_value = value.read_string).blank?
          Time.parse_rfc3339(time_value.to_s)
        else
          nil
        end
      end

      def self.to_json(value : self, json : JSON::Builder)
        json.string(value.to_rfc3339)
      end
    end
  end
end
