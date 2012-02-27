require 'rubygems'
require 'awesome_print'

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end

if ENV['RAILS_ENV']
  def logger
    rails_logger = ActiveRecord::Base.logger == Rails.logger ? Logger.new(STDOUT) : Rails.logger
    ActiveRecord::Base.logger = rails_logger
    ActiveResource::Base.logger = rails_logger
    reload!
    'toggled console logger'
  end
end
