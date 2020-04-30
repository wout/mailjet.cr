struct Mailjet
  abstract struct Path
    getter params : Hash(String, String)

    abstract def pattern

    def initialize(params : Hash | NamedTuple = Hash(String, String).new)
      @params = Utilities.to_stringified_hash(params)
    end

    def to_s : String
      (path = pattern).scan(/:([a-z_]+)/).each do |match|
        if value = @params[match[1]]?
          path = path.gsub(match[0], value)
        else
          raise ParamsMissingException.new(%(Missing param "#{match[1]}"))
        end
      end

      ensure_with_slash_and_version(path)
    end

    private def ensure_with_slash_and_version(path : String)
      path = path.lchop("/")
      path = "#{Config.api_version}/#{path}" unless path.match(/^v[\d\.]+/)
      "/#{path}"
    end
  end
end
