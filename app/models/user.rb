class User < ActiveRecord::Base
  UID_NUMBER_LOWER_BOUND = 10000
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true
  before_create :set_uid_same_as_name
  after_create :set_uid_number

  def send_on_create_confirmation_instructions;
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def registered?
    found_user = User.find_by(email: email)
    return (found_user.registered == true) if found_user
    false
  end

  def register!
    update_attributes(registered: true)
  end

  def ==(other)
    return false if other.nil? || is_user?(other)
    return true if self.object_id == other.object_id
    self.name == other.name && self.email == other.email
  end

  def hash
    [name, email].hash
  end

  private
  def set_uid_same_as_name
    self.uid = self.name
  end

  def set_uid_number
    update_attribute(:uid_number, id + UID_NUMBER_LOWER_BOUND)
    reset_email_to_saved_state
  end

  def reset_email_to_saved_state
    self.email = User.find(self.id).email
  end

  def is_user?(other)
    !other.is_a?(User)
  end
end
