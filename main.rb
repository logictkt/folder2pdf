require 'bundler'
Bundler.require

puts "Start Folder2PDF !"
ARGV.each_with_index do |path, i|
  Dir.chdir(path)
  folder_name = File.basename(Dir.pwd)
  puts "Create PDF ... #{folder_name} ..."
  r = Magick::ImageList.new()
  files = Dir.glob("*.{jpg,jpeg,JPG,png,PNG}")
  files = files.sort_by{ |s| s.scan(/(\d+)|([^\d]+)/) }
  files.each do |file|
    r.push(Magick::Image.read(file)[0])
  end
  r.write("../#{folder_name}.pdf")
  puts "Complete create PDF #{folder_name}."
end
puts "Finish Folder2PDF !"
