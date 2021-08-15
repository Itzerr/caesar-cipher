require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone(phone)
  phone.gsub!(/\D/, '')
  if phone.length == 10
    phone
  elsif phone.length == 11 && phone[0] == '1'
    phone[1..-1]
  else
    'Invalid phone number'
  end
end

def peak_registration_hours(hours)
  hours = hours.map { |time| Time.strptime(time, '%H:%M').hour }
  hours.tally.reduce([0, 0]) do |peak_hour_count, hour_count|
    peak_hour_count = hour_count if hour_count.last > peak_hour_count.last
    peak_hour_count
  end
end

def peak_registration_day(dates)
  dates = dates.map { |date| Date.strptime(date, '%m/%d/%y').strftime('%A') }
  dates.tally.reduce([0, 0]) do |peak_day_count, day_count|
    peak_day_count = day_count if day_count.last > peak_day_count.last
    peak_day_count
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager Initialized!'

contents = CSV.open(
  '../event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('../form_letter.erb')
erb_template = ERB.new template_letter

times = []
dates = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  times << row[:regdate].split.last
  dates << row[:regdate].split.first

  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  # puts phone
  # save_thank_you_letter(id, form_letter)
end

# puts "Peak Registration Hours: #{peak_registration_hours(times)}"
puts "Peak Registration Day: #{peak_registration_day(dates)}"
