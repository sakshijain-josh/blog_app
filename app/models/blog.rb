class Blog < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :published, -> { where(published: true) }
  scope :drafts, -> { where(published: false) }
end
