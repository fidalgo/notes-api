class User < ActiveRecord::Base
  has_secure_password
  has_many :notes

  after_initialize :default_role

  enum role: {admin: 0, user: 1, guest: 2 }

  validates_presence_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  private

  def default_role
    self.role ||= :user
  end

end
