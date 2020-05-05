struct Mailjet
  struct DNS
    # Perform a DNS validation of a sender domain. The Mailjet API will check
    # for a TXT record in the domain's DNS zone file.
    #
    # https://dev.mailjet.com/email/reference/sender-addresses-and-domains/dns/#v3_post_dns_dns_ID_check
    #
    struct Check < Resource
      alias ResponseData = Array(Details)

      # :nodoc:
      can_create("REST/dns/:id/check", ResponseData)

      # Check validit of a DNS record
      #
      # ```crystal
      # contact = Mailjet::DNS::Check.create(123456789)
      # ```
      #
      def self.create(
        id : ResourceId,
        client : Client = Client.new
      )
        create({} of String => String, {id: id}, client)
      end

      struct Details
        include Json::Fields

        json_fields({
          "DKIMErrors":              Array(String),
          "DKIMRecordCurrentValue":  String,
          "DKIMStatus":              String,
          "SPFErrors":               Array(String),
          "SPFRecordsCurrentValues": Array(String),
          "SPFStatus":               String,
        })
      end
    end
  end
end
