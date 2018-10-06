require 'bundler'
Bundler.require
require 'fileutils'

puts 'Start Folder2PDF ...'

def run_rmagic(dir, file_names, folder_name)
  file_names = Naturally.sort(file_names)
  image_list = Magick::ImageList.new(*file_names)
  image_list.write("#{File.expand_path('..', dir)}/#{folder_name}.pdf")
  image_list.destroy!
end

def make_pdf(dir)
  folder_name = File.basename(dir)
  puts "Create PDF --> #{dir}"
  file_names = Dir.glob("#{dir}/*.{jpg,jpeg,JPG,png,PNG}")
  run_rmagic(dir, file_names, folder_name) unless file_names.count.zero?
  # FileUtils.rm_rf(folder_name)
end

def search_dir_make_pdf(path)
  dirs = Naturally.sort(Dir.glob("#{path}/**/"))
  dirs.each { |dir| make_pdf(dir) }
end

ARGV.each do |path|
  search_dir_make_pdf(path)
end

puts "Finish Folder2PDF"
