class Entry < ActiveRecord::Base
  belongs_to :note
  validates_presence_of :line
  validates_length_of :line, minimum: 1
end
