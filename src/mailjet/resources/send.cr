struct Mailjet
  struct Send < Resource
    class_getter resource_path = "send"
    class_getter public_operations = %w[POST]

    def self.messages(messages : Array(Hash))
      create({"Messages" => messages})
    end

    struct Message
    end
  end
end
