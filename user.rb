require 'sinatra'
require './database.rb'
require './model.rb'
require 'data_mapper'
require 'dm-core'
enable :sessions

get '/login' do
  if(session['status']==1)
    redirect("/search")
  else
    session['status']=0
    erb:login
  end
end

get '/register' do
  session['status']=0
  erb:register, :locals => {
     :employee_register=> Employee.new
   }
end

get '/logout' do
  session['status']=0
  redirect("/login")
end

post '/register' do
  employee_register = Employee.new
  employee_register.attributes = params
  employee_register.save
  erb:success
end

post '/login' do
  password="#{params[:password]}"
  employee_result = Employee.first(:email=>"#{params[:email]}")
  if(employee_result != nil)
    if(employee_result.password == password)
      session['id']=employee_result.id
      session['status']=1
    else
      session['status']=2
    end
  else
    session['status']=2
  end
  if(session['status']==1)
    redirect('/search')
  else
    erb:login, :locals => {:c=>session['status']}
  end
end

