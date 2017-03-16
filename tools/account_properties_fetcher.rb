require 'rubygems'
require_relative 'mixpanel_client_tool'
require 'pry'

def fetch_account account_id
  client = mixpanel_client(:production, :accounts)

  puts "Fetching Mixpanel account properties of ID '#{account_id}'"
  data = client.request(
    'engage', 
    distinct_id: account_id
  )
  account_name = data["results"][0]["$properties"]["$name"]
  puts "Completed fetch of ID '#{account_id}: #{account_name}'"
  return data
end