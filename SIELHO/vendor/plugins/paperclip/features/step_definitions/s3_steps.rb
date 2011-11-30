When /^I attach the file "([^"]*)" to "([^"]*)" on S3$/ do |file_path, field|
  definition = User.attachment_definitions[field.downcase.to_sym]
  path = "http://s3.amazonaws.com/paperclip#{definition[:path]}"
  path.gsub!(':filename', File.basename(file_path))
  path.gsub!(/:([^\/\.]+)/) do |match|
    "([^\/\.]+)"
  end
  FakeWeb.register_uri(:put, Regexp.new(path), :body => "OK")
  When "I attach the file \"#{file_path}\" to \"#{field}\""
end

Then /^the file at "([^"]*)" should be uploaded to S3$/ do |url|
  FakeWeb.registered_uri?(:put, url)
end
