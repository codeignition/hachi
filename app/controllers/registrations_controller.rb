class RegistrationsController < Devise::RegistrationsController
  def create
    ldap_users = LdapUsers.new
    user = ldap_users.find_by_common_name(common_name)
    if (found?(user) && !user.registered? && user.valid?)
      user.save!
      user.send_confirmation_instructions
      user.register!
      flash[:notice] = confirmation_notice
    end
    redirect_to root_path
  end

  def confirmation_notice
    'A confirmation email has been sent to you'
  end

  private
  def common_name
    params['user']['email'].split('@').first
  end

  def found?(user)
    !user.nil?
  end
end
