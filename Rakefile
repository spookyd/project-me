#!/bin/ruby
require 'optparse'

RESUME_INPUT='Resume.json'

README_TEMPLATE='README.md.template'
PLAIN_TEXT_TEMPLATE='resume.txt.template'

OUTPUT_DIR='output/'
BORDER='--------------------------------------------------------------------------------'

namespace :parser do

  desc 'Loads in resume json file'
  task :load do
    require 'json'
    @parsed = JSON.parse(File.read(RESUME_INPUT))
    # TODO: Validate json
    format_basics @parsed['basics']
    format_skills @parsed['skills']
    format_experience @parsed['work']
    format_certifications @parsed['certifications']
    format_education @parsed['education']
    format_interests @parsed['interests']
  end

  def format_basics(basics)
    puts basics['name']
    puts basics['label']
    format_location basics['location']
    puts "Phone: #{basics['phone']}"
    puts "Email: #{basics['email']}"
    format_profiles basics['profiles']
  end

  def format_location(location)
    puts location['address']
    puts "#{location['city']}, #{location['region']} #{location['postalCode']}"
  end

  def format_summary(summary)
    puts BORDER
    puts summary
    puts BORDER
  end

  def format_profiles(profiles)
    profiles.each { |profile|
      puts "#{profile['network']}: #{profile['url']}"
    }
  end

  def format_skills(skills)
    puts BORDER
    puts 'SKILLS'
    puts BORDER
    skills.each { |skill|
      fmt_keywords = skill['keywords'].reduce('') { |keywords, keyword| keywords.to_s.empty? ? "#{keyword}" : "#{keywords}, #{keyword}" }
      puts "#{skill['name']}: #{fmt_keywords}"
    }
  end

  def format_experience(work)
    puts BORDER
    puts 'EXPERIENCE'
    puts BORDER
    work.each { |job|
      fmt_highlights = job['highlights'].reduce('') { |highlights, highlight|
        "#{highlights}\n* #{highlight}"
      }
      website = job['website']
      fmt_website = website.to_s.empty? ? '' : " - #{website}"
      puts "#{job['startDate']} - #{job['endDate']}\n#{job['position']}\n#{job['company']}#{fmt_website}\n#{job['summary']}\n#{fmt_highlights}\n\n"
    }
  end

  def format_certifications(certs)
    puts BORDER
    puts 'CERTIFICATIONS'
    puts BORDER
    certs_fmt = ''
    certs.each { |cert|
      certs_fmt += "#{cert['date']}\n#{cert['title']}\n#{cert['awarder']}\n\n"
    }
    puts certs_fmt
  end

  def format_education(education)
    puts BORDER
    puts 'EDUCATION'
    puts BORDER
    education_fmt = ''
    education.each { |institute|
      education_fmt += "#{institute['startDate']} - #{institute['endDate']}\n#{institute['studyType']}, #{institute['area']}\n#{institute['institution']}\nGPA: #{institute['gpa']}\n\n"
    }
    puts education_fmt
  end

  def format_interests(interests)
    puts BORDER
    puts 'INTERESTS'
    puts BORDER
    interests.each { |interest|
      fmt_keywords = interest['keywords'].reduce('') { |keywords, keyword| keywords.to_s.empty? ? "#{keyword}" : "#{keywords}, #{keyword}" }
      puts "#{interest['name']}: #{fmt_keywords}"
    }
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
    # open the file for writing
    File.open(file_name, "w") do |f|
      f.write(data)
    end
  end

  def rm_rf(dir)
    FileUtils.rm_rf dir
  end

end

task :generate_resume do
  copy_template PLAIN_TEXT_TEMPLATE, OUTPUT_DIR
  require 'json'
  parsed_json = load_json RESUME_INPUT
  formatted_data = format_template_data PLAIN_TEXT_TEMPLATE, parsed_json
  working_file = extract_file_name PLAIN_TEXT_TEMPLATE
  write_data formatted_data, "#{OUTPUT_DIR}#{working_file}"
end

task :clean do
  rm_rf OUTPUT_DIR
end

def format_template_data(template_file, parsed_json)
  # load the file as a string
  data = File.read(template_file)
  # globally substitute "install" for "latest"
  data.gsub("{{basics.name}}", "Test Me")
end

def extract_file_name(template)
  template.to_s.gsub('.template', '')
end

def copy_template(template, output_dest)
  file_name = extract_file_name template
  create_output output_dest
  cp template, "#{output_dest}#{file_name}"
end
