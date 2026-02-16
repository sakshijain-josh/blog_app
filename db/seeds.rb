Blog.destroy_all
Comment.destroy_all

20.times do |i|
  blog = Blog.create!(
    title: "Blog #{i + 1}",
    body: "Sample body #{i + 1}",
    published: i < 10
  )

  if blog.published?
    3.times do
      blog.comments.create!(body: "Sample comment")
    end
  end
end
