require 'rubygems'
require_relative 'account_properties_fetcher'
require 'pry'

$client_status = {}

def status_is_known? account_id
  return $client_status.has_key?(account_id)
end

def is_client? account_id
  puts "Checking if #{account_id} is a client"
  unless status_is_known? account_id
    account_properties = fetch_account(account_id)
    status = account_properties["results"][0]["$properties"]["É ou já foi Cliente"]
    $client_status[account_id] = status
    puts "ID #{account_id} status is #{status}"
    return status
  else
    return $client_status[account_id]
  end
end

def filter_events_by_property event_list, filter_property
  event_list.keep_if do |event|
    is_client?(event["properties"]["id"])
  end
  event_list
end