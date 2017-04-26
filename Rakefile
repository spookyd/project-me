#!/bin/ruby

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

namespace :txt_builder do

end

task :create, [:build_type] do |t, args|

end
