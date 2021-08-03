struct Mailjet
  class Exception < Exception
    alias ErrorInfoArray = Hash(String, Array(Hash(String, Int32 | String)))
    alias ErrorInfo = ErrorInfoArray | String?
  end

  # The error info value may return anything from a string to an array of
  # hashes, so some juggling is needed to drill down to the actual errors. Here
  # is an example:
  #
  # ```
  # case exception.error_info
  # when String
  #   puts exception.error_info
  # when Mailjet::Exception::ErrorInfoArray
  #   if contactslists = exception.error_info["ContactsLists"]?
  #     puts contactslists.map(&.["Error"]).join(", ")
  #   end
  # end
  # ```
  #
  class RequestException < Mailjet::Exception
    JSON.mapping({
      error_message: {key: "ErrorMessage", type: String?},
      error_info:    {key: "ErrorInfo", type: Exception::ErrorInfo},
      status_code:   {key: "StatusCode", type: Int32?},
    })

    def message
      "#{error_message} (#{status_code})"
    end

    def to_s
      message
    end
  end

  class ParamsMissingException < Mailjet::Exception; end

  class RequestTimeoutException < Mailjet::Exception; end

  class MethodNotAllowedException < Mailjet::Exception; end

  class InvalidEmailAddressException < Mailjet::Exception; end

  class MissingApiCredentialsException < Mailjet::Exception; end

  class ResourceNotFoundException < Mailjet::RequestException; end
end
