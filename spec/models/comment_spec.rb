require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'is valid with a body and published blog' do
      blog = create(:blog, :published)
      comment = build(:comment, body: 'Great post!', blog: blog)
      expect(comment).to be_valid
    end

    it 'is invalid if blog is not published' do
      blog = create(:blog, published: false)
      comment = build(:comment, blog: blog)
      expect(comment).not_to be_valid
      expect(comment.errors[:blog]).to include("not published")
    end
  end

  describe 'associations' do
    it 'belongs to a blog' do
      association = described_class.reflect_on_association(:blog)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
