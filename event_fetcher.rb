require 'rubygems'
require 'mixpanel_client'
require 'pry'

MIXPANEL_CREDENTIALS = {
  production: { api_key: '08925f6df006ceecbfced4fa86d15689', api_secret: '72751e52dc4623bc2bfccab2f9f276f2'},
  sandbox:  { api_key: 'ee318283baf5e2beeffa2acc0bbe5518', api_secret: '009226cee54a4ab43e0df6e04ffa569e'}
}

MIXPANEL_END_POINT = {
  segmentation: 'https://mixpanel.com/api/2.0/segmentation/',
  people: 'https://mixpanel.com/api/2.0/engage/'
}

def mixpanel_client environment = :production, end_point = :segmentation
  client = Mixpanel::Client.new(
    api_key:    MIXPANEL_CREDENTIALS[environment][:api_key],
    api_secret: MIXPANEL_CREDENTIALS[environment][:api_secret]
  )
  client.request_uri(MIXPANEL_END_POINT[end_point])
  return client
end

def fetch_raw_events from_date, to_date, event_name, environment = :production, output = 'json'
  client = mixpanel_client

  puts "Fetching Mixpanel data of '#{event_name.upcase}'"
  data = client.request(
    'export', from_date: from_date, to_date: to_date, event: [event_name], format: output
  )
end

#Example:
# event_list = [
#   'Criou a Conta',
#   'SmartNextStep: SmartNextStep View'
# ]
# data = fetch_raw_events('2017-03-03', '2017-03-04', event_list)
# puts data


