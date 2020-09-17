# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Deleting tables..."

connection = ActiveRecord::Base.connection()
connection.execute("delete from action_text_rich_texts");
connection.execute("delete from active_storage_attachments");
connection.execute("delete from active_storage_blobs");
# connection.execute("delete from friendly_id_slugs");
connection.close()

Tagging.delete_all
Comment.delete_all
Post.delete_all
Tag.delete_all 
Category.delete_all
User.delete_all

# create will immediately persist the record to the DB
tag_js = Tag.create(name: "javascript")
tag_react = Tag.create(name: "react")
tag_ruby = Tag.create(name: "ruby")
tag_rails = Tag.create(name: "rails")


cat_web = Category.create(
    name: "Web Development", 
    description: "All about web development"
)

cat_prog = Category.create(
  name: "Programming", 
  description: "All about programming"
)

cat_js = Category.create(
  name: "JavaScript", 
  description: "All about javascript"
)


abhinav = User.create(
  email: "abhinav@gmail.com",
  password: "123456",
  password_confirmation: "123456"
)

admin = User.create(
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456"
)


10.times do |i|
  Post.create(
    user: i % 2 == 0 ? abhinav : admin,
    title: "Post #{i}",
    body: "Post #{i} goes here...",
    tags: i % 2 == 0 ? [tag_rails, tag_ruby] : [tag_js, tag_react],
    published: true,
    category_id: i % 2 == 0 ? cat_js.id : cat_prog.id
  )
end

Post.all.each do |post|
  3.times do |i|
    post.comments.build(
        title: Faker::ChuckNorris.fact,
        content: Faker::ChuckNorris.fact,
        user: i%2==0 ? abhinav : admin
    )
    post.save
  end
end