# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_phone  (phone) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "initialize user" do
    user = User.create!(email: 'foobar@example.com', password: 'password')
  end
end
