# == Schema Information
#
# Table name: favorites
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#  document_id :integer          not null
#
class Favorite < ApplicationRecord
  belongs_to :customers
  belongs_to :documents
end
