# == Schema Information
#
# Table name: invitations
#
#  id             :uuid             not null, primary key
#  email_or_phone :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_id       :bigint           not null
#  invitee_id     :bigint
#  inviter_id     :bigint           not null
#
# Indexes
#
#  index_invitations_on_email_or_phone_and_group_id  (email_or_phone,group_id) UNIQUE
#  index_invitations_on_group_id                     (group_id)
#  index_invitations_on_invitee_id                   (invitee_id)
#  index_invitations_on_inviter_id                   (inviter_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (invitee_id => users.id)
#  fk_rails_...  (inviter_id => users.id)
#
class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :inviter, class_name: :User
  belongs_to :invitee, class_name: :User
end
