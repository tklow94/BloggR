# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


#disable div tag adding to input field that hits a validation error which messes up styling.

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    html_tag.html_safe 
end

