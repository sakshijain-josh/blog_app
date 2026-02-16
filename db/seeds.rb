Blog.destroy_all
Comment.destroy_all

puts "Creating blogs with Faker..."

# Create 20 blogs with realistic data
20.times do |i|
  blog = Blog.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    published: i < 10  # First 10 are published
  )

  # Add comments to published blogs
  if blog.published?
    rand(2..5).times do
      blog.comments.create!(
        body: Faker::Lorem.sentence(word_count: rand(5..15))
      )
    end
  end

  print "." if (i + 1) % 5 == 0
end

puts "\nSeeding complete!"
puts "Created #{Blog.count} blogs (#{Blog.published.count} published, #{Blog.drafts.count} drafts)"
puts "Created #{Comment.count} comments"
