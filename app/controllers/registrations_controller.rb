class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.find_by_email(params['user']['email'])
    if (user_not_nil(user) && user.valid?)
      user.send_confirmation_instructions
      user.update_attributes(registered: true)
    end
    redirect_to root_path
  end

  private
  def user_not_nil(user)
    !user.nil?
  end
end
