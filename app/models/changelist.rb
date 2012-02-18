class Changelist < ActiveRecord::Base
  validates :p4number, :uniqueness => true
end
