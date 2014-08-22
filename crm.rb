require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite3:database.sqlite3')

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :notes, String

end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
	@crm_app_name = "Sara's CRM"
	erb :index		
end

get "/contact" do
  @contacts = Contact.all
  erb :contact
end

get "/index" do
	erb :index
end

get "/contact/new" do
	erb :new_contact
end

post '/contact' do
  contact = Contact.create(
      :first_name =>params[:first_name],
      :last_name =>params[:last_name],
      :email =>params[:email],
      :notes =>params[:notes]
    )
end

get "/contact/:id" do
  @contact = Contact.get(params[:id].to_i)
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

    redirect to("/contact")		
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


