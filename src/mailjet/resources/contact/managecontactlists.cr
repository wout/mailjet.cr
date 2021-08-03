struct Mailjet
  struct Contact
    # Manage the presence and subscription status of a contact for multiple
    # contact lists. Select the contact lists, as well as the desired action to
    # be performed on each one - add, remove or unsub. The contact should
    # already be present in the global contact list.
    #
    # https://dev.mailjet.com/email/reference/contacts/subscriptions#v3_post_contact_contact_ID_managecontactslists
    #
    struct Managecontactlists < Resource
      alias ContactLists = Array(Hash(String, Array(ContactList)))

      # :nodoc:
      can_create("REST/contact/:contact_id/managecontactslists", ContactLists)

      # Manage the presence and subscription status of a contact for multiple
      # contact lists.
      #
      # ```
      # contact_lists = Mailjet::Contact::Managecontactlists.create(54321987, [
      #   {list_id: 23847, action: "addnoforce"},
      #   {list_id: 26484, action: "addforce"},
      # ])
      # puts contact_lists.first.list_id
      # # => 23847
      # ```
      #
      def self.create(
        contact_id : ResourceId,
        contacts_lists : Array
      )
        create(
          {contacts_lists: contacts_lists},
          {contact_id: contact_id}
        )["ContactsLists"]
      end

      struct ContactList
        include Json::Fields

        json_fields({
          "Action": String,
          "ListID": Int32,
        })
      end
    end
  end
end
