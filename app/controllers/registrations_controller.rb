class RegistrationsController < Devise::RegistrationsController
  def create
    ldap_users = LdapUsers.new
    user = ldap_users.find_by_common_name(common_name)
    if (user_found?(user) && !user.registered?)
      user.save!
      user.send_confirmation_instructions
      user.register!
      flash[:notice] = 'A confirmation email has been sent to you'
    end
    redirect_to root_path
  end

  private
  def user_not_nil(user)
    !user.nil?
  end

  def common_name
    params['user']['email'].split('@').first
  end

  def user_found?(user)
    user_not_nil(user) && user.valid?
  end
end
