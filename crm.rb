require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'

@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Stefanie", "Gibson", "s@bitmakerlabs.com", "Rockstar"))
@@rolodex.add_contact(Contact.new("Donna", "Ha", "d@bitmakerlabs.com", "Rockstar"))

get '/' do
	@crm_app_name = "Sara's CRM"
	erb :index		# localhost:4567/index
end

get "/contact" do
  erb :contact
end

get "/index" do
	erb :index
end

# add new contact
get "/contact/new" do
	erb :new_contact
end

post '/contact' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:notes])
  @@rolodex.add_contact(new_contact)
  redirect to('/contact')		
end

get "/contact/:id" do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

put "/contact/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]

    redirect to("/contact")		# redirect is always a get req
  else
    raise Sinatra::NotFound
  end
end

get "/contact/:id/edit" do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

delete "/contact/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contact")
  else
    raise Sinatra::NotFound
  end
end


