require 'sinatra'
require './database.rb'
require 'data_mapper'
require './model.rb'
require 'dm-core'
require 'dm-paperclip'
def make_paperclip_mash(file_hash)
  mash = Mash.new
  if(params[:file]!=nil)
    mash['tempfile'] = file_hash[:tempfile]
    mash['filename'] = file_hash[:filename]
    mash['content_type'] = file_hash[:type]
    mash['size'] = file_hash[:tempfile].size
    mash
  end
end

get '/search' do
  if(session['status']!=1)
    redirect("/login")
  else
    erb:search
  end
end

get '/share' do
  if(session['status']!=1)
    redirect("/login")
  else
    erb:share, :locals => {
      :file_share=> ShareFile.new
   }
  end
end

get '/myfile' do
  if(session['status']!=1)
    redirect("/login")
  else
    my_file=EmployeeShareFile.all(:employee_id=>session['id'])
    file=ShareFile.all
    erb :myfile, :locals=> {
      :file=> file,
      :my_file=> my_file
      }
  end
end
 

post '/share' do
  register=Employee.first(:id=>session['id'])
  if(params[:file]!=nil)
    File.open('uploads/' + params['file'][:filename], "w") do |f|
      f.write(params['file'][:tempfile].read)
      resource = ShareFile.new(:file => make_paperclip_mash(params[:file]),:tags =>(params[:tags]))
      halt 409, "There were some errors processing your request...\n#{resource.errors.inspect}" unless resource.save
      employee_resource= EmployeeShareFile.new(:share_file_id=>(resource.id),:employee_id=>(register.id))
      employee_resource.save
    end
  else
    file_share =ShareText.new
    file_share.attributes = params
    file_share.save
    employee_share_texts= EmployeeShareText.new(:share_text_id=>(file_share.id),:employee_id=>(register.id))
    employee_share_texts.save
  end
  erb:successshare
end

post '/search' do
  session['video']="{params[:search]}"
  file_result = ShareFile.all
  text_result =ShareText.all
  erb :searchshow, :locals => { :file_result => file_result,:text_result => text_result,
    :search_text=>"#{params[:search]}"}
end

get'/files/original/:filename' do |filename|
  #send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
  erb :showfile, :locals => {:filename => filename, :type => 'Application/octet-stream'}
end

get '/video/:search_text' do
  file_result = ShareFile.all
  erb :showvideo, :locals => { :file_result => file_result,
    :search_text=>"#{params[:search_text]}"}
end

get '/image/:search_text' do
  file_result = ShareFile.all
  erb :showimage, :locals => { :file_result => file_result,
    :search_text=>"#{params[:search_text]}"}
end
get '/pdf/:search_text' do
  file_result = ShareFile.all
  erb :showpdf, :locals => { :file_result => file_result,
    :search_text=>"#{params[:search_text]}"}
end
get '/audio/:search_text' do
  file_result = ShareFile.all
  erb :showaudio, :locals => { :file_result => file_result,
    :search_text=>"#{params[:search_text]}"}
end
get '/all/:search_text' do
  file_result = ShareFile.all
  erb :showall, :locals => { :file_result => file_result,
    :search_text=>"#{params[:search_text]}"}
end