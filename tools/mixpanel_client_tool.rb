require 'rubygems'
require 'mixpanel_client'
require_relative '../config/mixpanel_credentials'

MIXPANEL_END_POINT = {
  segmentation: 'https://mixpanel.com/api/2.0/segmentation/',
  accounts: 'https://mixpanel.com/api/2.0/engage/'
}

def mixpanel_client environment = :production, end_point = :segmentation
  unless MIXPANEL_CREDENTIALS[environment][:api_key] == 'insert_here'
    client = Mixpanel::Client.new(
      api_key:    MIXPANEL_CREDENTIALS[environment][:api_key],
      api_secret: MIXPANEL_CREDENTIALS[environment][:api_secret]
    )
    client.request_uri(MIXPANEL_END_POINT[end_point])
    return client
  else
    raise "Mixpanel credentials are not set. See /config/ to change it."
  end
end