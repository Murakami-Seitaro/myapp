# == Schema Information
#
# Table name: documents
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  feeling     :integer          default("happy"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#
require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
