require "../../resource"

struct Mailjet
  # Retrieve the contents of a campaign draft. It will be split between a Text
  # part, HTML part, MJML content and/or additional headers.
  #
  # https://dev.mailjet.com/email/reference/campaigns/drafts/#v3_get_campaigndraft_draft_ID_detailcontent
  # https://dev.mailjet.com/email/reference/campaigns/drafts/#v3_post_campaigndraft_draft_ID_detailcontent
  #
  struct Campaigndraft
    struct Detailcontent < Resource
      alias ResponseData = Array(JSON::Any)

      # Find content for a campaigndraft
      #
      # ```
      # campaigndraft = Mailjet::Campaigndraft::Detailcontent.find(12345)
      # ```
      #
      can_find("REST/campaigndraft/:id/detailcontent", ResponseData)

      # :nodoc:
      can_create("REST/campaigndraft/:id/detailcontent", ResponseData)

      # Create content for a campaigndraft
      #
      # ```
      # campaigndraft = Mailjet::Campaigndraft::Detailcontent.create(12345, {
      #   "Headers": {
      #     "Subject":  "Hello There!",
      #     "From":     "John Doe <email@example.com>",
      #     "Reply-To": "",
      #   },
      #   "Html-part": "<html><body><p>Hello {{var:name}}</p></body></html>",
      #   "Text-part": "Hello {{var:name}}",
      #   "Mjml-part": "",
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
    end
  end
end
