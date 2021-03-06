class Link < ApplicationRecord
  belongs_to :question, dependent: :destroy

  validates_presence_of :name, :website_link_text

end
