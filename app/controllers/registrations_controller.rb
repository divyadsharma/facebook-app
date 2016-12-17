class RegistrationsController < Devise::RegistrationsController
  def new
    user = User.find_by_email(params[:email])
    if user
      redirect_to new_user_session_path(token: params[:token], error: I18n.t(
          'access_denied')
                                        )
    else
      build_resource(email: params[:email])
      respond_with resource
    end
  end

  def create
    if params[:user].present? && params[:user][:password].present?
      params[:user][:password] = params[:user][:password_confirmation]
    end
    user = User.create user_params
    if user.errors.present?
      if user.errors.messages[:email].present?
        flash[:alert] = "user #{user.errors.messages[:email].first}"
      elsif user.errors.messages[:password].present?
        flash[:alert] = "password #{user.errors.messages[:password].first}"
      elsif user.errors.messages[:username].present?
        flash[:alert] = "user name #{user.errors.messages[:username].first}"
      end
      redirect_to new_user_registration_path
    else
      flash.now[:notice] = 'Welcome! You have signed up successfully.'
      session['uid'] = user.id
      sign_in(user)
      redirect_to root_path
    end
  end

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :password, :password_confirmation)
  end
end
