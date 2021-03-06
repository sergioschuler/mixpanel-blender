require 'rubygems'
require_relative 'mixpanel_client_tool'
require 'pry'

def fetch_raw_events (
                      from_date, 
                      to_date, 
                      event_name, 
                      filters = {is_client: true},
                      environment = :production, 
                      output = 'json')

  client = mixpanel_client

  puts "Fetching Mixpanel data of '#{event_name.upcase}'"
  data = client.request(
    'export', 
    from_date: from_date, 
    to_date: to_date, 
    event: [event_name], 
    format: output
  )
  puts "Completed fetch for '#{event_name.upcase}'"
  puts "Sample event:"
  puts data.first

  unless filters == false
    filters.each do |k, v|
      data = filter_events_by_property(data, k, v)
    end
  end

  return data

  # if filters[:is_client] = true
  #   filtered_data = filter_events_by_property(data, "is_client")
  #   return filtered_data
  # else
  #   return data
  # end
end