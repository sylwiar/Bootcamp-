class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  belongs_to :person

  accepts_nested_attributes_for :person
end
