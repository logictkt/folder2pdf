require 'bundler'
Bundler.require
require 'fileutils'

puts "Start Folder2PDF ..."

def run_rmagic file_names, folder_name
  file_names = Naturally.sort(file_names)
  image_list = Magick::ImageList.new(*file_names)
  image_list.write("../#{folder_name}.pdf")
  image_list.destroy!
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
  return unless Dir.exist?(path)
  Dir.chdir(path)
  if Dir.glob('*').any? { |dir| Dir.exist?("./#{dir}") }
    Dir.glob('*').each do |folder|
      next unless Dir.exist?("./#{folder}")
      search_dir_make_pdf(File.join(path, folder))
    end
  else
    make_pdf(path)
  end
end

ARGV.each do |path|
  search_dir_make_pdf(path)
end

puts "Finish Folder2PDF"
