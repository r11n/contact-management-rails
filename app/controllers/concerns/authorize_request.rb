module AuthorizeRequest
    extend ActiveSupport::Concern
    attr_reader :current_user

    private  
    def authorize_request   
        @current_user = AuthorizeApiRequest.new(request.headers).call  
    end

    def current_user
        @current_user 
    end
   
    def authorization?
      return true if request.headers['Authorization'].present?       
    end
end