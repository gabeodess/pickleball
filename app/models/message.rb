class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :body, presence: true

  def as_json_v1
    as_json(methods: [:name])
  end

  def name
    user.email
  end
end
