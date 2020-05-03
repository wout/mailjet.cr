struct Mailjet
  struct Contact
    struct List < Resource
      alias ResponseData = Array(Details)

      # Find all contact lists for a given contact id
      #
      # ```crystal
      # response = Mailjet::Contact::List.all(params: {contact_id: 52856551})
      # contactlists = response.data
      # ```
      #
      can_list("REST/contact/:contact_id/getcontactslists", ResponseData)

      # Convenience method allowing to pass the contact id and returning the
      # array of lists directly
      #
      # ```crystal
      # contactlists = Mailjet::Contact::List.all(52856551)
      # ```
      #
      def self.all(
        contact_id : ResourceId,
        client : Client = Client.new
      )
        all(params: {contact_id: contact_id}, client: client).data
      end

      struct Details
        include Json::Fields

        json_fields({
          "IsActive":     Bool,
          "IsUnsub":      Bool,
          "ListID":       Int32,
          "SubscribedAt": Time,
        })
      end
    end
  end
end
