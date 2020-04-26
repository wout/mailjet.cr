struct Mailjet
  class Exception < Exception; end

  class RequestTimeoutException < Mailjet::Exception; end

  class MethodNotAllowedException < Mailjet::Exception; end

  class InvalidEmailAddressException < Mailjet::Exception; end

  class MissingApiCredentialsException < Mailjet::Exception; end
end
