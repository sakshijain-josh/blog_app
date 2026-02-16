namespace :blogs do
  desc "Print published and unpublished blog counts"
  task stats: :environment do
    published_count = Blog.published.count
    unpublished_count = Blog.drafts.count
    total_count = Blog.count

    puts "=" * 50
    puts "Blog Statistics"
    puts "=" * 50
    puts "Published Blogs:   #{published_count}"
    puts "Unpublished Blogs: #{unpublished_count}"
    puts "Total Blogs:       #{total_count}"
    puts "=" * 50
  end
end
