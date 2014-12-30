puts "Input your email:"
user_email = gets.chomp
user = User.create!(email: user_email)
puts

puts "What do you want to do?\n
0. Create shortened URL
1. Visit shortened URL"
choice = gets.chomp.to_i

case choice
when 0
  puts "Type in your long URL."
  long_url = gets.chomp
  short_url = ShortenedUrl.create_for_user_and_long_url!(user, long_url)
  puts "Type in your category."
  tag = gets.chomp
  puts "Short url is: #{short_url}"
  ShortenedUrl.record_tagging!(tag, short_url)

when 1
  puts "Type in the shortened URL."
  short_url = gets.chomp
  Visit.record_visit!(user, short_url)
  Launchy.open(ShortenedUrl.get_long_url(short_url))
end
