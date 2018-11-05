class AuthenticationController < ActionController::API
	include ActionController::MimeResponds
	include ExceptionHandler
	
	 def authenticate	
		auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call	
		render json: { auth_token: auth_token }, status: :ok
	 end

	 def signup
		user = User.new(signup_params)
		if user.save
			auth_token = AuthenticateUser.new(signup_params[:email], signup_params[:password]).call
			render json: { auth_token: auth_token }, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	 end
	 private
	 def auth_params
    	params.require(:user).permit(:email, :password)
	 end
	 
	 def signup_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :plain_identity)
	 end
	 
end
