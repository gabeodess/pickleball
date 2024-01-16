class Group < ApplicationRecord
  belongs_to :owner, class_name: :User
  has_many :members, class_name: :GroupMember
  has_many :users, through: :members
  has_many :messages

  validates :name, presence: true
end
