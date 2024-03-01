# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  doubles         :float            default(0.0), not null
#  email           :string
#  password_digest :string
#  phone           :string
#  singles         :float            default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  dupr_id         :bigint
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_phone  (phone) UNIQUE
#
class User < ApplicationRecord
  def self.find_by_email_or_phone(value)
  end

  has_secure_password

  has_many :pushers
  has_many :owned_groups, class_name: :Group, foreign_key: :owner_id
  has_many :group_members
  has_many :groups, through: :group_members

  def first_name
    email.split(/[^a-zA-Z]/).first
  end

  def as_json_v1
    as_json(only: [:id, :email, :doubles, :singles, :dupr_id])
  end
end
