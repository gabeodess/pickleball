# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_groups_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Group < ApplicationRecord
  belongs_to :owner, class_name: :User
  has_many :members, class_name: :GroupMember
  has_many :users, through: :members
  has_many :messages
  has_many :invitations

  validates :name, presence: true
end
