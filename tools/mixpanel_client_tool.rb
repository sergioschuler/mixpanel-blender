require 'rubygems'
require 'mixpanel_client'
require_relative '../config/mixpanel_credentials'

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