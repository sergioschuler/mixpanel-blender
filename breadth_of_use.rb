require_relative 'tools/require_all_tools'
require 'date'
require 'pry'

def generate_breadth_events_csv (event_list, from_date = Date.today - 90, to_date = Date.today)
  event_list.each do |event|
	  events = fetch_raw_events(
      from_date, 
      to_date, 
      event, 
      filters = {is_client: true, channel: 'inbound'})
	  write_csv(events)
	end
end

event_list = [
  "Criou a Conta",
	"Publicou Landing Page",
  "Agendou o envio de email no novo fluxo de email",
  "Enviou um email pelo novo fluxo de email",
  "SocialMedia: PostEditor Add",
  "Criou Segmentacao de Leads",
  "Popups: Popup Add",
  "Criou campo personalizado",
  "Criou um Formulário",
  "Criou Fluxo de Automacao",
  "Ativou Fluxo de Automacao"
]

from_date = '2016-11-03'
to_date = '2017-03-19'

# from_date = '2017-03-15'
# to_date = '2017-03-16'

generate_breadth_events_csv(event_list, from_date, to_date)