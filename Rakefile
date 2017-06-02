#!/bin/ruby
require 'optparse'

namespace :file_management do

  require 'fileutils'

  def load_json(file)
    return JSON.parse(File.read(file), :symbolize_names => true)
  end

  def create_output(directory)
    unless File.directory?(directory)
      FileUtils.mkdir_p(directory)
    end
  end

  def cp(from, to)
    FileUtils.cp from to
  end

  def cp_recursive(from, to)
    FileUtils.cp_r from to
  end

  def write_data(data, file_name)
    File.new(file_name, "w") unless File.exist?(file_name)
    # open the file for writing
    File.open(file_name, "w") do |f|
      f.write(data)
    end
  end

  def rm_rf(dir)
    FileUtils.rm_rf dir
  end

end

namespace :assets do

  desc 'Bundles assets for deployment'
  task :bundle do |args|
    options = {
      output_dir: 'output/'
    }
    option_parser = OptionParser.new
    option_parser.banner = "Usage: rake resume:generate -- t"
    option_parser.on("-o OUTPUT", "--output OUTPUT", String, "Specifies the output directory") do |output|
      options[:output_dir] = output
    end
    args = option_parser.order!(ARGV) {}
    option_parser.parse!(args)

    create_output "#{options[:output_dir]}"
    cp_r 'assets/', "#{options[:output_dir]}."

  end

end

namespace :resume do |args|
  desc "Generates a resume.package"
  task :generate do

    # USAGE: rake resume:generate -- -t txt -i resume.json -o ~/resume_output -x ~/template_txt.erb -n my_resume
    options = {
      type: 'all',
      output_dir: 'output/',
      input_file: 'resume.json',
      readme_template: './tasks/resume_readme.erb',
      txt_template: './tasks/resume_txt.erb',
      resume_name: nil
    }
    option_parser = OptionParser.new
    option_parser.banner = "Usage: rake resume:generate -- t"
    option_parser.on("-t TYPE", "--type TYPE", String, "Specifies the type of resume to generate") do |type|
      if type == 'txt' || type == 'readme'
        options[:type] = type
      end
    end
    option_parser.on("-o OUTPUT", "--output OUTPUT", String, "Specifies the output directory to place the resume resources") do |output|
      options[:output_dir] = output
    end
    option_parser.on("-i INPUT", "--input INPUT", String, "Specifies the resume.json file to use for input") do |input|
      options[:input_file] = input
    end
    option_parser.on("-r README", "--readme README", String, "Specifies the location of the readme erb file") do |readme|
      options[:readme_template] = readme
    end
    option_parser.on("-x TXT", "--txt TXT", String, "Specifies the location of the txt erb file") do |txt|
      options[:txt_template] = txt
    end
    option_parser.on("-n NAME", "--name NAME", String, "Specifies the name of the resume output file") do |txt|
      options[:txt_template] = txt
    end
    args = option_parser.order!(ARGV) {}
    option_parser.parse!(args)
    #-- end
    if options[:type] == 'all'
      options[:template] = options[:readme_template]
      options[:ext] = 'md'
      generate_resume options
      options[:template] = options[:txt_template]
      options[:ext] = 'txt'
      generate_resume options
      cp options[:input_file], options[:output_dir]
      options[:ext] = 'json'
    elsif options[:type] == 'txt'
      options[:template] = options[:txt_template]
      options[:ext] = 'txt'
      generate_resume options
    elsif options[:type] == 'readme'
      options[:template] = options[:readme_template]
      options[:ext] = 'md'
      generate_resume options
    elsif options[:type] == 'json'
      cp options[:input_file], options[:output_dir]
      options[:ext] = 'json'
    end
    exit
  end

  def generate_resume(opts)
    create_output opts[:output_dir]
    template = opts[:template]
    require 'json'
    parsed_json = load_json opts[:input_file]
    require_relative './tasks/resume_generator.rb'
    generator = ResumeGenerator.new(parsed_json, File.read(template))
    formatted_data = generator.render
    file_name = opts[:name]
    if file_name.nil?
      date = Time.now.strftime("%m_%Y")
      file_name = "#{parsed_json[:basics][:name].gsub(/\s/,'_')}_#{date}.#{opts[:ext]}"
    end
    write_data formatted_data, "#{opts[:output_dir]}#{file_name}"
  end

  def package()

  end

  def deploy()

  end

end
