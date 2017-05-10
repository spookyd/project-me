#!/bin/ruby
require 'erb'

class ResumeTxtGenerator
  include ERB::Util
  attr_accessor :resume
  def initialize(resume, template)
    @resume = resume
    @template = template
  end
  def render()
    ERB.new(@template).result(binding)
  end
end
