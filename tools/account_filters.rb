require 'rubygems'
require_relative 'account_properties_fetcher'
require 'pry'

$client_status = {}

def client_status_is_known? account_id
  return $client_status.has_key?(account_id)
end

def is_client? account_id
  puts "Checking if #{account_id} is a client"
  unless client_status_is_known? account_id
    account_properties = fetch_account(account_id)
    status = account_properties["results"][0]["$properties"]["É ou já foi Cliente"]
    $client_status[account_id] = status
    puts "ID #{account_id} status is #{status}"
    return status
  else
    return $client_status[account_id]
  end
end

$sales_channel_status = {}

def sales_channel_status_is_known? account_id
  return $sales_channel_status.has_key?(account_id)
end

def sales_channel account_id, channel
  puts "Checking if #{account_id} is of channel #{channel}"
  status = ""
  unless sales_channel_status_is_known? account_id
    account_properties = fetch_account(account_id)
    status = account_properties["results"][0]["$properties"]["Channel"]
    $sales_channel_status[account_id] = status
    puts "ID #{account_id} channel is #{status}"
  else
    status = $sales_channel_status[account_id]
  end
  
  if status.capitalize == channel.capitalize
    return true
  else
    return false
  end
end

def filter_events_by_property event_list, filter_property, filter_value
  if filter_property == :is_client
    if filter_value == true
      event_list.keep_if { |event| is_client?(event["properties"]["id"]) }
    else
      event_list.delete_if { |event| is_client?(event["properties"]["id"]) }
    end
  end

  if filter_property == :channel
    event_list.keep_if { |event| sales_channel(event["properties"]["id"], filter_value) }
  end
      
  event_list
end