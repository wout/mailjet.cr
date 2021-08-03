struct Mailjet
  # Retrieve the contents of an email template. It will be split between a Text
  # part, HTML part, MJML content and/or additional headers.
  #
  # https://dev.mailjet.com/email/reference/templates/#v3_get_template_template_ID_detailcontent
  # https://dev.mailjet.com/email/reference/templates/#v3_post_template_template_ID_detailcontent
  # https://dev.mailjet.com/email/reference/templates/#v3_put_template_template_ID_detailcontent
  #
  struct Template
    struct Detailcontent < Resource
      alias ResponseData = Array(JSON::Any)

      # Find content details for a template
      #
      # ```
      # template = Mailjet::Template::Detailcontent.find(12345)
      # ```
      #
      can_find("REST/template/:id/detailcontent", ResponseData)

      # :nodoc:
      can_create("REST/template/:id/detailcontent", ResponseData)

      # Create content details for a template
      #
      # ```
      # template = Mailjet::Template::Detailcontent.create(12345, {
      #   author:     "John Doe",
      #   categories: [
      #     "commerce",
      #   ],
      #   copyright:   "John Doe",
      #   description: "Used for discount promotion.",
      #   ...
      # })
      # ```
      #
      def self.create(
        id : ResourceId,
        payload : Hash | NamedTuple,
        client : Client = Client.new
      )
        create(payload, {id: id}, client: client)
      end

      # Update content details for a template
      #
      # ```
      # template = Mailjet::Template::Detailcontent.update(12345, {
      #   author:     "John Doe",
      #   categories: [
      #     "commerce",
      #   ],
      #   copyright:   "John Doe",
      #   description: "Used for discount promotion.",
      #   ...
      # })
      # ```
      #
      can_update("REST/template/:id/detailcontent", ResponseData)
    end
  end
end
