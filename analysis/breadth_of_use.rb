require '../event_fetcher'
require '../csv_writer'
require 'date'
require 'pry'

def fetch_account_ids (from_date = Date.today - 1, to_date = Date.today)
  events = fetch_raw_events(from_date, to_date, ["Criou a Conta"])
  write_csv(events)
end

fetch_account_ids
