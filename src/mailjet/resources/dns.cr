struct Mailjet
  struct DNS < Resource
    class_getter resource_path = "REST/dns"
    class_getter public_operations = %w[GET]
  end
end
