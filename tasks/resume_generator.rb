#!/bin/ruby
require 'erb'

class ResumeGenerator
  include ERB::Util
  attr_accessor :resume
  def initialize(resume, template)
    @resume = resume
    @template = template
  end
  def render()
    ERB.new(@template, nil, '-').result(binding)
  end
end
