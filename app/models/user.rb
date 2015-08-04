class User < ActiveRecord::Base
  has_secure_password
  has_many :notes

  after_initialize :default_role

  enum role: [ :admin, :user, :guest ]

  validates_presence_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  private

  def default_role
    self.role ||= :user
  end

end
