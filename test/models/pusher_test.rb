# == Schema Information
#
# Table name: pushers
#
#  id         :bigint           not null, primary key
#  auth       :string           not null
#  endpoint   :string           not null
#  p256dh     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pushers_on_endpoint  (endpoint) UNIQUE
#  index_pushers_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PusherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
