require 'bundler'
Bundler.require
require 'fileutils'

puts 'Start Folder2PDF ...'

def run_rmagic(dir, file_names, folder_name)
  file_names = Naturally.sort(file_names)
  image_list = Magick::ImageList.new(*file_names)
  image_list.write("#{File.expand_path(dir)}/#{folder_name}.pdf")
  image_list.destroy!
end

def make_pdf(dir, path)
  Dir::chdir(dir)
  folder_name = File.basename(dir)
  file_names  = Dir.glob("*.{jpg,jpeg,png,webp}")
  unless file_names.count.zero?
    puts "Create PDF --> #{dir}"
    run_rmagic(File::dirname(Dir::pwd), file_names, folder_name)
  end
  Dir::chdir(path)
  # FileUtils.rm_rf(folder_name)
end

def search_dir_make_pdf(path)
  Dir::chdir(path)
  dirs = Naturally.sort(Dir.glob("**/"))
  if dirs.empty?
    make_pdf(path, path)
  else
    dirs.each { |dir| make_pdf(dir, path) }
  end
end

ARGV.each do |path|
  search_dir_make_pdf(path)
end

puts "Finish Folder2PDF"
