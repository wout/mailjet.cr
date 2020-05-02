struct Mailjet
  struct Json
    struct NilableTime
      def self.from_json(value : JSON::PullParser)
        time_string = value.read_string
        unless time_string.blank?
          Time.from_json(time_string)
        end
      end

      def self.to_json(value : self, json : JSON::Builder)
        json.string(value.to_s)
      end
    end
  end
end
