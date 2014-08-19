require_relative 'contact'
require 'sinatra'

get '/' do
	@crm_app_name = "My CRM"
	erb :index		# localhost:4567/index
end

# add new contact
get "/contacts/new" do

end

# Edit new contact
get "/contacts/:id/edit" do

end

# view contact
get "/contacts/:id" do		# :id is a wildcard, and new is explicit, so they'll try to put new into id instead

end

get "/contacts" do

end