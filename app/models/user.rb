class User < ApplicationRecord
    has_secure_password

    has_many :pushers
    has_many :owned_groups, class_name: :Group, foreign_key: :owner_id
    has_many :group_members
    has_many :groups, through: :group_members

    def first_name
      email.split(/[^a-zA-Z]/).first
    end

    def as_json_v1
      as_json(only: [:id, :email])
    end
end
