struct Mailjet
  struct AddressList
    getter address_list : String
    getter addresses : Array(Address)

    forward_missing_to addresses

    def initialize(@address_list : String)
      @addresses = parse(address_list)
    end

    private def parse(address_list)
      address_list.split(",").map do |address|
        if match = address.match(/(([^<]+)<)?([^>]+)>?/)
          display_name = (match[2]? || "").strip
          address = match[3].strip
          Address.new(address, display_name)
        end
      end.compact
    end
  end
end
