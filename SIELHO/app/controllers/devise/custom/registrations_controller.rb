class Devise::Custom::RegistrationsController < Devise::RegistrationsController
	def new
		super
		@user = User.new
	end

	def create
		a= params[:user]
		super
		user = User.find_by_email(a[:email])
		
		user.agregar_admin(params)
	end
	
	def update
		super
	end

	def edit
		super
	end		

	protected

	def after_sign_up_path_for(resource)
		new_user_session_path
	end

	def after_inactive_sign_up_path_for(resource)
		new_user_session_path
	end
end
