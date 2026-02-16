module Blogs
  class PublishingService
    def initialize(blog)
      @blog = blog
    end

    def call
      return { success: false, error: "Blog not found" } unless @blog
      return { success: false, error: "Blog already published" } if @blog.published?

      if @blog.update(published: true)
        { success: true, blog: @blog }
      else
        { success: false, error: @blog.errors.full_messages.join(", ") }
      end
    end

    # Class method for convenience
    def self.call(blog)
      new(blog).call
    end
  end
end
