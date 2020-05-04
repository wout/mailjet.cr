struct Mailjet
  struct Contact
    # Retrieve all contact lists for a specific contact. You will receive
    # information on the status of the contact for each list. Information about
    # lists deleted within the last 60 days will be returned as well, since
    # those are soft-deleted and can be reinstated.
    #
    # https://dev.mailjet.com/email/reference/contacts/subscriptions#v3_get_contact_contact_ID_getcontactslists
    #
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
