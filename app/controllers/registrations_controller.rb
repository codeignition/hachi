class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.find_by_email(params['user']['email'])
    if (user.valid?)
      user.send_confirmation_instructions
    end
    render nothing: true
  end
end