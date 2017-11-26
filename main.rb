require 'bundler'
Bundler.require
require 'fileutils'

puts "Start Folder2PDF ..."

def sort_file_name(file_names)
  first_word_value_hash = {}
  sort_target_datas = file_names.map do |file_name|
                   { sort_title: file_name.scan(/(\d+)|([^\d]+)/).map{ |a| a[1] || a[0].to_i }, base_title: file_name }
                 end
  sort_target_datas.each do |name_hash|
    first_word_value_hash["#{name_hash[:sort_title].first}"] = [] if first_word_value_hash["#{name_hash[:sort_title].first}"].nil?
    first_word_value_hash["#{name_hash[:sort_title].first}"] << name_hash
  end
  first_word_value_hash = first_word_value_hash.sort_by { |key, value| key }
  result = []
  first_word_value_hash.each do |first_word, file_name_datas|
    arr = file_name_datas.sort_by do |file_name_data|
            file_name_data[:sort_title]
          end
    result.concat(arr.map { |file_name_data| file_name_data[:base_title] })
  end
  result
end

def run_rmagic file_names, folder_name
  r = Magick::ImageList.new()
  file_names = sort_file_name(file_names)
  file_names.each do |file|
    r.push(Magick::Image.read(file)[0])
  end
  r.write("../#{folder_name}.pdf")
end

def make_pdf path
  Dir.chdir(path)
  folder_name = File.basename(Dir.pwd)
  puts "Create PDF --> #{folder_name}"
  file_names = Dir.glob("*.{jpg,jpeg,JPG,png,PNG}")
  run_rmagic(file_names, folder_name) unless file_names.count.zero?
  # Dir.chdir('../')
  # FileUtils.rm_rf(folder_name)
  puts "Complete!"
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
