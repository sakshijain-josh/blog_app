module Blogs
  class AutoPublishJob < ApplicationJob
    queue_as :default

    def perform(blog_id)
      blog = Blog.find_by(id: blog_id)
      return unless blog

      # Only publish if still unpublished
      Blogs::PublishingService.call(blog) unless blog.published?
    end
  end
end
