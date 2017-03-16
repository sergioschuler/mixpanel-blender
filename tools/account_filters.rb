require 'rubygems'
require_relative 'account_properties_fetcher'
require 'pry'

$clients_status = {}

def status_is_known? account_id
  return $clients_status.has_key?(account_id)
end

def is_client? account_id
  unless status_is_known? account_id
    account_properties = fetch_account(account_id)
    status = account_properties["results"][0]["$properties"]["É ou já foi Cliente"]
    $clients_status[account_id] = status
    return status
  else
    return $clients_status[account_id]
  end
end