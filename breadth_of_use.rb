require_relative 'tools/require_all_tools'
require 'date'
require 'pry'

def generate_breadth_events_csv (event_list, from_date = Date.today - 90, to_date = Date.today)
  event_list.each do |event|
	  events = fetch_raw_events(
      from_date, 
      to_date, 
      event, 
      filters = {is_client: true})
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

from_date = '2017-03-09'
to_date = '2017-03-09'

generate_breadth_events_csv(["Ativou Fluxo de Automacao"], from_date, to_date)