class Note < ActiveRecord::Base

  belongs_to :user
  has_many :entries
  validates_presence_of :title

end
