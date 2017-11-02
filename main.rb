require 'bundler'
Bundler.require
require 'fileutils'

puts "Start Folder2PDF ..."

def run_rmagic files, folder_name
  r = Magick::ImageList.new()
  files = files,sort_by{ |s| s.scan(/(\d+)|([^\d]+)/).map{ |a| a[1] || a[0].to_i } }
  files.each do |file|
    r.push(Magick::Image.read(file)[0])
  end
  r.write("../#{folder_name}.pdf")
end

def make_pdf path
  Dir.chdir(path)
  folder_name = File.basename(Dir.pwd)
  puts "Create PDF --> #{folder_name}"
  files = Dir.glob("*.{jpg,jpeg,JPG,png,PNG}")
  run_rmagic(files, folder_name) unless files.count.zero?
  # Dir.chdir('../')
  # FileUtils.rm_rf(folder_name)
  puts "Complete!"
end

ARGV.each_with_index do |path, i|
  Dir.chdir(path)
  if Dir.exist?("./#{Dir.glob("*").first}")
    folders = Dir.glob("*")
    folders.each do |folder|
      make_pdf(File.join(path, folder))
    end
  else
    make_pdf(path)
  end
end

puts "Finish Folder2PDF"
