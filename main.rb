require 'bundler'
Bundler.require
require 'fileutils'

puts "Start Folder2PDF ..."

def run_rmagic file_names, folder_name
  r = Magick::ImageList.new()
  file_names = Naturally.sort(file_names)
  file_names.each do |file|
    r.push(Magick::Image.read(file)[0])
  end
  r.write("../#{folder_name}.pdf")
  r.destroy!
end

def make_pdf path
  Dir.chdir(path)
  folder_name = File.basename(Dir.pwd)
  puts "Create PDF --> #{folder_name}"
  file_names = Dir.glob("*.{jpg,jpeg,JPG,png,PNG}")
  run_rmagic(file_names, folder_name) unless file_names.count.zero?
  Dir.chdir('../')
  # FileUtils.rm_rf(folder_name)
end

def search_dir_make_pdf path
  Dir.chdir(path)
  if Dir.exist?("./#{Dir.glob("*").first}")
    folders = Dir.glob("*")
    folders.each do |folder|
      search_dir_make_pdf(File.join(path, folder))
    end
  else
    make_pdf(path)
  end
end

ARGV.each_with_index do |path, i|
  search_dir_make_pdf(path)
end

puts "Finish Folder2PDF"
