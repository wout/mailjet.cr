struct Mailjet
  abstract struct Resource
    include JSON::Serializable

    class_getter action : String? = nil
    property persisted = false

    ALLOWED_OPTIONS = %w[
      api_key
      open_timeout
      perform_api_call
      read_timeout
      secret_key
      url
      version
    ]

    def self.create(
      attributes : Hash = Alias::HS2.new,
      options : Hash = Alias::HS2.new
    )
      # ensure_correct_resource_path(attributes)
      # attributes = create_action_attributes(attributes)
      # options = define_options(options)

      # new(attributes).tap do |resource|
      #   resource.save!(options)
      #   resource.persisted = true
      # end

    end

    private def self.ensure_correct_resource_path(attributes : Hash)
      # if action && attributes["id"]?
      #   self.resource_path = create_action_resource_path(attributes["id"])
      # end
    end

    private def self.create_action_attributes(attributes : Hash)
      if resource_path == "send/" && (from = Mailjet::Config.default_from)
        address = AddressList.new(from).first
        attributes = attributes.merge({
          :from_email => address.address,
          :from_name  => address.display_name,
        })
      end

      attributes.transform_keys(&.to_s).tap(&.delete("id"))
    end

    private def self.create_action_resource_path(
      id : Int32,
      job_id : Int32? = nil
    )
      parts = resource_path.split("/")
      parts.delete_at(parts.length - 1) if parts.last.to_i > 0

      if !(parts[1] == "contacts" && self.action == "managemanycontacts")
        parts[2] = id.to_s
      end

      parts << job_id.to_s if job_id
      parts.join("/")
    end

    private def self.define_options(options : Hash = Alias::HS2.new)
      defaults = {
        "version" => Mailjet.config.api_version,
        "url"     => Mailjet.config.end_point,
      }
      defaults.merge(options.transform_keys(&.to_s).slice(*ALLOWED_OPTIONS))
    end

    private def self.client
      Client.new(self.resource_path)
    end
  end
end
