require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'validations' do
    it 'is valid with title and body' do
      blog = build(:blog, title: 'Test Blog', body: 'Test Body')
      expect(blog).to be_valid
    end

    it 'is invalid without a title' do
      blog = build(:blog, title: nil)
      expect(blog).not_to be_valid
      expect(blog.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a body' do
      blog = build(:blog, body: nil)
      expect(blog).not_to be_valid
      expect(blog.errors[:body]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end

    it 'destroys associated comments when deleted' do
      blog = create(:blog, :published)
      comment = create(:comment, blog: blog)
      
      expect { blog.destroy }.to change(Comment, :count).by(-1)
    end
  end

  describe 'scopes' do
    let!(:published_blog) { create(:blog, :published) }
    let!(:draft_blog) { create(:blog, published: false) }

    it '.published returns only published blogs' do
      expect(Blog.published).to include(published_blog)
      expect(Blog.published).not_to include(draft_blog)
    end

    it '.drafts returns only unpublished blogs' do
      expect(Blog.drafts).to include(draft_blog)
      expect(Blog.drafts).not_to include(published_blog)
    end
  end
end
