require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

@@rolodex = Rolodex.new

get '/' do
	@crm_app_name = "My CRM"
	erb :index		# localhost:4567/index
end

get "/contacts" do
  erb :contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')		# redirect is always a get req
end

# add new contact
get "/contacts/new" do
	erb :new_contact
end

# Edit new contact
get "/contacts/:id/edit" do

end

# view contact
get "/contacts/:id" do		# :id is a wildcard, and new is explicit, so they'll try to put new into id instead

end

