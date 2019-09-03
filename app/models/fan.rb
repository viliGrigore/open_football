class Fan < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :alcoholic_level

  belongs_to :team

end
