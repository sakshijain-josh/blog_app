require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  describe "GET /blogs" do
    let!(:published_blogs) { create_list(:blog, 3, :published) }
    let!(:draft_blogs) { create_list(:blog, 2, published: false) }

    it "returns http success" do
      get blogs_path
      expect(response).to have_http_status(:success)
    end

    it "displays only published blogs in the response" do
      get blogs_path
      published_blogs.each do |blog|
        expect(response.body).to include(blog.title)
      end
    end
  end

  describe "GET /blogs/drafts" do
    let!(:published_blogs) { create_list(:blog, 2, :published) }
    let!(:draft_blogs) { create_list(:blog, 3, published: false) }

    it "returns http success" do
      get drafts_blogs_path
      expect(response).to have_http_status(:success)
    end

    it "displays draft blogs in the response" do
      get drafts_blogs_path
      draft_blogs.each do |blog|
        expect(response.body).to include(blog.title)
      end
    end
  end
end
