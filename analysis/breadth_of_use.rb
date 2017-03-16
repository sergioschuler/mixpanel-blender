require '../event_fetcher'
require '../csv_writer'
require 'date'
require 'pry'

def generate_breadth_events_csv (event_list, from_date = Date.today - 1, to_date = Date.today)
  event_list.each do |event|
	  events = fetch_raw_events(from_date, to_date, event)
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

generate_breadth_events_csv(event_list)