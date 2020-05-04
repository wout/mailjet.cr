struct Mailjet
  abstract struct Path
    getter params : Hash(String, String)

    abstract def pattern

    def initialize(params : Hash | NamedTuple = Hash(String, String).new)
      @params = ensure_stringified_with_version(params)
    end

    def to_s : String
      path = "/:version/#{pattern.lchop("/")}"
      path.scan(/:([a-z_]+)/).each do |match|
        if value = @params[match[1]]?
          path = path.gsub(match[0], value)
        else
          raise ParamsMissingException.new(%(Missing param "#{match[1]}"))
        end
      end
      path
    end

    private def ensure_stringified_with_version(params)
      {"version" => Config.api_version}
        .merge(Utilities.to_stringified_hash(params))
    end
  end
end
