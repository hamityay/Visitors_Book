class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #
  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  #
  # def failure
  #   redirect_to root_path
  # end

  def facebook
    auth = request.env['omniauth.auth']
    if auth.info.email.present?
      @user = User.from_omniauth(auth)
      if @user.persisted?
        flash[:success] = t('flash.messages.user.signed_in_with_facebook') if is_navigational_format?
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.facebook_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    else
      flash[:danger] = t('flash.messages.email_required')
      redirect_to new_user_registration_url
    end
  end

end