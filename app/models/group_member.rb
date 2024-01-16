class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :group

  delegate :email, to: :user

  def as_json_v1
    as_json(methods: [:email])
  end
end
