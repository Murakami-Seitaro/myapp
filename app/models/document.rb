# == Schema Information
#
# Table name: documents
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  feeling     :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#
class Document < ApplicationRecord
  belongs_to :customers

  has_many :tag_documents, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
