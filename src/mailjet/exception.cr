struct Mailjet
  class Exception < Exception; end

  class InvalidEmailAddressException < Mailjet::Exception; end
end
