class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    include ExceptionHandler
    before_action :authorize_request
end
