class RegistrationsController < Devise::RegistrationsController
  def new
    user = User.find_by_email(params[:email])
    # session[:user_return_to] = params[:token] unless params[:token].blank?
    # session[:course_token] = params[:token] unless params[:token].blank?
    if user
      redirect_to new_user_session_path(token: params[:token], error: I18n.t(
          'access_denied')
                                         )
    else
      binding.pry
      build_resource(email: params[:email])
      respond_with resource
    end
  end

  def create
    binding.pry
    if params[:user].present? && params[:user][:password].present?
      params[:user][:password] = params[:user][:password_confirmation]
    end
    @user = User.create user_params
    if user.errors.present?
      flash[:alert] = 'sorry'
      redirect_to new_user_registration_path
    else
      flash.now[:notice] = 'signed up'
      session['uid'] = user.id
      sign_in(user)
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
