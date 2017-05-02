#!/bin/ruby
require 'optparse'

RESUME_INPUT='Resume.json'

README_TEMPLATE='README.md.template'
PLAIN_TEXT_TEMPLATE='resume.txt.template'

OUTPUT_DIR='output/'
BORDER='--------------------------------------------------------------------------------'

namespace :parser do

  def map_resume_to_file_data(resume, file_data)
    # TODO: Validate json
    file_data = replace_data_with_value 'meta.border', BORDER, file_data
    file_data = format_basics resume['basics'], file_data
    file_data = format_skills resume['skills'], file_data
    file_data = format_experience resume['work'], file_data
    file_data = format_certifications resume['certifications'], file_data
    file_data = format_education resume['education'], file_data
    file_data = format_interests resume['interests'], file_data
    return file_data
  end

  def format_basics(basics, file_data)
    root_key = 'basics'
    prop_key = 'name'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key, basics[prop_key], file_data
    prop_key = 'label'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key, basics[prop_key], file_data
    prop_key = 'summary'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key, basics[prop_key], file_data
    prop_key = 'location'
    file_data = format_location basics[prop_key], file_data
    prop_key = 'phone'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key, basics[prop_key], file_data
    prop_key = 'email'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key, basics[prop_key], file_data
    prop_key = 'profiles'
    data_key = to_parse_key root_key, prop_key
    profiles_fmt = build_profiles basics[prop_key]
    file_data = replace_data_with_value  data_key, profiles_fmt, file_data
    return file_data
  end

  def format_location(location, file_data)
    root_key = 'location'
    prop_key = 'address'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key , location[prop_key], file_data
    prop_key = 'city'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key , location[prop_key], file_data
    prop_key = 'region'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key , location[prop_key], file_data
    prop_key = 'postalCode'
    data_key = to_parse_key root_key, prop_key
    file_data = replace_data_with_value  data_key , location[prop_key], file_data
  end

  def build_profiles(profiles)
    profiles_fmt = ''
    profiles.each { |profile|
      if !profiles_fmt.empty?
        profiles_fmt += "\n"
      end
      profiles_fmt += "#{profile['network']}: #{profile['url']}"
    }
    return profiles_fmt
  end

  def format_skills(skills, file_data)
    skills_fmt = ''
    skills.each { |skill|
      if !skills_fmt.empty?
        skills_fmt += "\n"
      end
      fmt_keywords = skill['keywords'].reduce('') { |keywords, keyword| keywords.to_s.empty? ? "#{keyword}" : "#{keywords}, #{keyword}" }
      skills_fmt += "#{skill['name']}: #{fmt_keywords}"
    }
    return replace_data_with_value  'skills', skills_fmt, file_data
  end

  def format_experience(work, file_data)
    work_fmt = ''
    work.each { |job|
      fmt_highlights = job['highlights'].reduce('') { |highlights, highlight|
        "#{highlights}\n* #{highlight}"
      }
      website = job['website']
      fmt_website = website.to_s.empty? ? '' : " - #{website}"
      if !work_fmt.empty?
        work_fmt += "\n"
      end
      work_fmt += "#{job['startDate']} - #{job['endDate']}\n#{job['position']}\n#{job['company']}#{fmt_website}\n#{job['location']}\n#{job['summary']}\n#{fmt_highlights}\n"
    }
    return replace_data_with_value  'work', work_fmt, file_data
  end

  def format_certifications(certs, file_data)
    certs_fmt = ''
    certs.each { |cert|
      if !certs_fmt.empty?
        certs_fmt += "\n"
      end
      certs_fmt += "#{cert['date']}\n#{cert['title']}\n#{cert['awarder']}\n"
    }
    return replace_data_with_value 'certifications', certs_fmt, file_data
  end

  def format_education(education, file_data)
    education_fmt = ''
    education.each { |institute|
      if !education_fmt.empty?
        education_fmt += "\n"
      end
      education_fmt += "#{institute['startDate']} - #{institute['endDate']}\n#{institute['studyType']}, #{institute['area']}\n#{institute['institution']}\nGPA: #{institute['gpa']}\n"
    }
    return replace_data_with_value 'education', education_fmt, file_data
  end

  def format_interests(interests, file_data)
    interest_fmt = ''
    interests.each { |interest|
      if !interest_fmt.empty?
        interest_fmt += "\n"
      end
      fmt_keywords = interest['keywords'].reduce('') { |keywords, keyword| keywords.to_s.empty? ? "#{keyword}" : "#{keywords}, #{keyword}" }
      interest_fmt += "#{interest['name']}: #{fmt_keywords}\n"
    }
    return replace_data_with_value 'interests', interest_fmt, file_data
  end

  def to_parse_key(parent, child)
    "#{parent}.#{child}"
  end

  def replace_data_with_value(key, value, file_data)
    return file_data.gsub("<<#{key}>>", value)
  end

end

namespace :file_management do

  require 'fileutils'

  def load_json(file)
    return JSON.parse(File.read(file))
  end

  def create_output(directory)
    unless File.directory?(directory)
      FileUtils.mkdir_p(directory)
    end
  end

  def cp(from, to)
    FileUtils.cp from to
  end

  def write_data(data, file_name)
    puts "Writing data #{data} to #{file_name}"
    # open the file for writing
    File.open(file_name, "w") do |f|
      f.write(data)
    end
  end

  def rm_rf(dir)
    FileUtils.rm_rf dir
  end

end

task :clean do
  rm_rf OUTPUT_DIR
end

def format_template_data(template_file, parsed_json)
  data = File.read(template_file)
  return map_resume_to_file_data parsed_json, data
end

def extract_file_name(template)
  template.to_s.gsub('.template', '')
end

def copy_template(template, output_dest)
  file_name = extract_file_name template
  create_output output_dest
  cp template, "#{output_dest}#{file_name}"
end

namespace :resume do |args|
  desc "Generates a resume.package"
  task :generate do

    # USAGE: rake programs:download -- rm
    #-- Setting options $ rake programs:download -- --rm
    options = {
      type: 'all',
      output_dir: 'output/',
      input_file: 'resume.json',
      readme_template: 'README.md.template',
      txt_template: 'Resume.txt.template'
    }
    option_parser = OptionParser.new
    option_parser.banner = "Usage: rake resume:generate -- t"
    option_parser.on("-t TYPE", "--type TYPE", String, "Specifies the type of resume to generate") do |type|
      if type == 'txt' || type == 'readme'
        options[:type] = type
      end
    end
    args = option_parser.order!(ARGV) {}
    option_parser.parse!(args)
    #-- end
    if options[:type] == 'all'
      options[:template] = options[:readme_template]
      generate_resume options
      options[:template] = options[:txt_template]
      generate_resume options
      cp options[:input_file], options[:output_dir]
    elsif options[:type] == 'txt'
      options[:template] = options[:txt_template]
      generate_resume options
    elsif options[:type] == 'readme'
      options[:template] = options[:readme_template]
      generate_resume options
    elsif options[:type] == 'json'
      cp options[:input_file], options[:output_dir]
    end
    exit
  end

  def generate_resume(opts)
    template = opts[:template]
    copy_template template, opts[:output_dir]
    require 'json'
    parsed_json = load_json opts[:input_file]
    formatted_data = format_template_data template, parsed_json
    working_file = extract_file_name template
    write_data formatted_data, "#{opts[:output_dir]}#{working_file}"
  end

end
