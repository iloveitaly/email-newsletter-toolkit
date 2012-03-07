#!/usr/bin/env ruby

require 'optparse'

# http://ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/OptionParser.html

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-c", "--copy TYPE", String, "Copy data to clipboard") do |v|
    options[:copy] = v
  end
end.parse!

# assumed that it is being run from root level email directory

# get last modified file
last_modified_files = nil

10.times do |i|
  time_modified = i * 1 + 1
  last_modified_files = %x[find $PWD -and -not -path "*.git" -and -name "*html" -and -not -path "*processed*" -mtime -#{time_modified}m].strip!
  
  break unless last_modified_files.nil?
end

if last_modified_files.nil? or last_modified_files.count("\n") > 0
  # TODO: in the future optional parameter for specifying file
  if not last_modified_files.nil?
    $stderr.puts "More than one file modified... not sure which test to send: \n" + last_modified_files
  else
    $stderr.puts "No recently modified files"
  end
  
  Process.exit
end

require 'rubygems'
require 'premailer'
require 'mail'

email_dir = File.dirname last_modified_files
email_file = last_modified_files
email_contents = File.open(email_file, 'r') { |f| f.read }

# extract title from <title>
stripped_email_subject = /<title>(?:[^|]+)?(?:[ |]{1,2})?([^<]+)<\/title>/.match(email_contents)[1]
email_subject = "Test Message - " + stripped_email_subject

Dir.chdir email_dir

premailer = Premailer.new email_file,
  :warn_level => Premailer::Warnings::SAFE,
  :remove_classes => true,
  :remove_comments => true,
  :base_url => %x[. #{email_dir}/config.bash && echo $BASE_URL]

# Output any CSS warnings
premailer.warnings.each do |w|
  puts "#{w[:message]} (#{w[:level]}) may not render properly in #{w[:clients]}"
end

email_lists = {
  :group => "email1@domain.com, email2@domain.com"
  :another_group => "email1@domain.com, email2@domain.com"
}

email_list = "default@email.com"

if ARGV.length > 0 and email_lists.has_key? ARGV[0].to_sym
  email_list = email_lists[ARGV[0].to_sym]
elsif ARGV.length > 0 and not /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/.match(ARGV[0]).nil?
  email_list = [ARGV[0]]
end

puts "Sending to: #{email_list}"

plain_text_email = premailer.to_plain_text
html_email = /<body[^>]*>(.*)<\/body>/m.match(premailer.to_inline_css)[1]

mail = Mail.new do
  to      email_list
  from    'newsletter@ascensionpress.net'
  subject email_subject

  text_part do
    body plain_text_email
  end

  html_part do
    content_type 'text/html; charset=UTF-8'
    body html_email
  end
end

mail.delivery_method :sendmail
mail.deliver

unless options[:copy].nil?
  require 'open3'
  stdin, stdout, stderr = Open3.popen3('pbcopy') 
  puts "Copying to clipboard..."
  
  if options[:copy] == "plain"
    stdin.puts plain_text_email
  else
    stdin.puts html_email
  end
end
