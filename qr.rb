require "rqrcode"

# Different ways to use it
# qrcode = RQRCode::QRCode.new("WIFI:T:WPA;S:My wifi network;P:supersecretpassword;;")
# qrcode = RQRCode::QRCode.new("SMSTO:9876543210:Hi Alice! It's")
# qrcode = RQRCode::QRCode.new("https://en.wikipedia.org/wiki/QR_code")

puts "What kind of QR code would you like to generate?"

puts "1. Open a URL"
puts "2. Join a wifi network"
puts "3. Send a text message"

puts "Press 4 to exit"

user_choice = gets.chomp

def png_create(qr)
  puts "What would you like to call the PNG?"
  png_name = gets.chomp
  png_name
  png = qr.as_png(size: 250)
  IO.binwrite("#{png_name}.png", png.to_s)
end

case user_choice
when "1"
  puts "What is the URL you would like to encode?"
  qr_url = gets.chomp
  qr = RQRCode::QRCode.new(qr_url)
  png_create(qr)
when "2"
  puts "What is the name of the wifi network?"
  network_name = gets.chomp
  puts "What is the password?"
  network_password = gets.chomp
  qr = RQRCode::QRCode.new("WIFI:T:WPA;S:#{network_name};P:#{network_password};;")
  png_create(qr)
when "3"
  puts "What is the phone number you want the code to send a text message to?"
  phone_number = gets.chomp
  puts "What do you want to populate the message with?"
  text_message = gets.chomp
  qr = RQRCode::QRCode.new("SMSTO:#{phone_number}:#{text_message}")
  png_create(qr)
when "4"
  puts "Good Bye!"
else
  puts "Invalid choice, please try again"
end
