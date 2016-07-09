class Person < ActiveRecord::Base
  validates :first_name, presence: true

  has_many :parkings, foreign_key: 'owner_id'
  has_many :cars, foreign_key: 'owner_id'

  def name
    [first_name, last_name].compact.join(' ')
  end
end
