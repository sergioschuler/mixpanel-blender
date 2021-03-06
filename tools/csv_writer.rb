require 'csv'
require 'fileutils'
require 'pry'

def generate_csv_name (raw_event_array)
   puts "Generating CSV name"
   event_name = raw_event_array.first["event"]
   from_date = Time.at(raw_event_array.first["properties"]["time"]).strftime("%Y-%m-%d")
   to_date = Time.at(raw_event_array.last["properties"]["time"]).strftime("%Y-%m-%d")
   timestamp = Time.now.to_i
   csv_name = "#{from_date}--#{to_date}-#{timestamp}_#{event_name}.csv"
   puts "CSV name generated: #{csv_name}"
   return csv_name
end

def parse_event_headers(event)
  puts "Parsing CSV headers"
  headers = ["Account ID", "Event name", "Event date", "Event time", event["properties"].keys].flatten
  puts "CSV header parsed: #{headers}"
  return headers
end

def parse_event_values(event)
  array_line_to_write = [
    account_id = event["properties"]["id"],
    event_name = event["event"],
    event_date = Time.at(event["properties"]["time"].to_i).strftime("%Y-%m-%d"),
    event_time = Time.at(event["properties"]["time"].to_i).strftime("%H:%M:%S"),
    event["properties"].values
  ].flatten
end

def write_csv (raw_event_array)
  csv_name = generate_csv_name(raw_event_array)
  folder_name = "csv"

  unless File.directory?(folder_name)
    FileUtils.mkdir_p(folder_name)
    puts "Folder '#{folder_name}' created"
  end

  CSV.open("#{folder_name}/#{csv_name}", "a") do |csv|
    csv << parse_event_headers(raw_event_array.last)
  end

  raw_event_array.each do |event|
    CSV.open("#{folder_name}/#{csv_name}", "a") do |csv|
      csv << parse_event_values(event)
    end
  end
end

# dummy = {"event"=>"Criou a Conta", "properties"=>{"time"=>1489450308, "distinct_id"=>"31352", "account_name"=>"Valentys Indústria e Comércio Ltda", "id"=>"31352", "id_user"=>71398, "mp_lib"=>"Segment: analytics-ruby"}},
# {"event"=>"Criou a Conta", "properties"=>{"time"=>1489450511, "distinct_id"=>"31353", "account_name"=>"Ranshoesoriginal", "id"=>"31353", "id_user"=>71399, "mp_lib"=>"Segment: analytics-ruby"}},
# {"event"=>"Criou a Conta", "properties"=>{"time"=>1489456753, "distinct_id"=>"31354", "account_name"=>"Corporalle Estética Avançada", "id"=>"31354", "id_user"=>71400, "mp_lib"=>"Segment: analytics-ruby"}},
# {"event"=>"Criou a Conta", "properties"=>{"time"=>1489478474, "distinct_id"=>"31355", "account_name"=>"patriceavilabarbosa-Me", "id"=>"31355", "id_user"=>71402, "mp_lib"=>"Segment: analytics-ruby"}},
# {"event"=>"Criou a Conta", "properties"=>{"time"=>1489481298, "distinct_id"=>"31356", "account_name"=>"Fausto Oliveira", "id"=>"31356", "id_user"=>71409, "mp_lib"=>"Segment: analytics-ruby"}},
# {"event"=>"Criou a Conta", "properties"=>{"time"=>1489481719, "distinct_id"=>"31357", "account_name"=>"Galo Design&Conteúdo", "id"=>"31357", "id_user"=>71410, "mp_lib"=>"Segment: analytics-ruby"}},
# {"event"=>"Criou a Conta", "properties"=>{"time"=>1489481868, "distinct_id"=>"31358", "account_name"=>"Domina Modas", "id"=>"31358", "id_user"=>71411, "mp_lib"=>"Segment: analytics-ruby"}}
