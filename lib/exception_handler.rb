module ExceptionHandler
    extend ActiveSupport::Concern
  
    # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
    class ExpireToken < StandardError; end
  
    included do
      # Define custom handlers
      rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
      rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ExceptionHandler::ExpireToken, with: :token_expire

    end
  
    private 

    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def four_twenty_two(e)
      json_response({ message: e.message }, 422)      
    end  
   
    def unauthorized_request(e) 
      json_response({ message: e.message }, :unauthorized)      
    end

    def not_found(e) 
      json_response({ message: e.message }, :not_found)      
    end

    def invalid_request_error(e)
      json_response({ message: e.message }, 404) 
    end

    def authentication_error(e)
      json_response({ message: e.message }, 402) 
    end

    def api_connection_error(e)
      json_response({ message: e.message }, 401) 
    end

    def rate_limit_error(e)
      json_response({ message: e.message }, 429) 
    end

    def token_expire(e)
       json_response({ message: e.message }, 429) 
    end

   
  end