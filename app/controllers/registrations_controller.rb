class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.find_by_email(params['user']['email'])
    if (user_found?(user) && !user.registered?)
      user.send_confirmation_instructions
      user.register!
      flash[:notice] = 'A confirmation email has been sent to you'
    else
      flash[:notice] = 'You are not a part of this organization'
    end
    redirect_to root_path
  end

  def user_found?(user)
    user_not_nil(user) && user.valid?
  end

  private
  def user_not_nil(user)
    !user.nil?
  end
end
