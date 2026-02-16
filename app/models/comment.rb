class Comment < ApplicationRecord
  belongs_to :blog

  validate :blog_must_be_published

  def blog_must_be_published
    errors.add(:blog, "not published") unless blog&.published?
  end
end
