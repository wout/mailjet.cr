struct Mailjet
  struct Address
    getter address : String
    getter display_name : String
    getter address_list : String

    def initialize(@address_list)
      email = AddressList.new(address_list).first
      @address = email.address
      @display_name = email.display_name
    end

    def initialize(@address, @display_name)
      @address_list = "#{@display_name} <#{@address}>"
    end
  end
end
