struct Mailjet
  class Exception < Exception; end

  class ParamsMissingException < Mailjet::Exception; end

  class RequestTimeoutException < Mailjet::Exception; end

  class MethodNotAllowedException < Mailjet::Exception; end

  class InvalidEmailAddressException < Mailjet::Exception; end

  class MissingApiCredentialsException < Mailjet::Exception; end

  class RequestException < Mailjet::Exception
    JSON.mapping({
      error_message: {key: "ErrorMessage", type: String?},
      error_info:    {key: "ErrorInfo", type: String?},
      status_code:   {key: "StatusCode", type: Int32?},
    })

    def message
      info = error_info == "" ? error_info : "#{error_info}; "
      "#{error_message} (#{info}#{status_code})"
    end

    def to_s
      message
    end
  end

  class ResourceNotFoundException < Mailjet::RequestException; end
end
