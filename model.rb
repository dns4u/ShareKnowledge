require 'sinatra'
require './database.rb'
require 'data_mapper'
require 'dm-core'
require 'dm-paperclip'
APP_ROOT = File.expand_path(File.dirname(__FILE__))
DataMapper.setup( :default, "mysql://root:dinesh 770@localhost/usershare" )

class Employee
  include DataMapper::Resource
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :gender, String
  property :address, String
  property :mobile_number,String
  property :email, String
  property :password, String
  property :position, String
  has n, :employee_resource
  has n, :share_file, :through => :employee_resource
  has n, :employee_share_text
  has n, :share_text, :through => :employee_share_text
end

class ShareText
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  property :tags, String
  property :share_text, String 
  has n, :employee_share_text
  has n, :employee, :through => :employee_share_text
end

class ShareFile
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial 
  property :tags, String
  has_attached_file :file,
                        :url => "/:attachment/:style/:basename.:extension",
                        :path => "#{APP_ROOT}/public/:attachment/:style/:basename.:extension"
  has n, :employee_resource
  has n, :employee, :through => :employee_resource
end

class EmployeeResource
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  belongs_to :share_file, :key => true
  belongs_to :employee, :key => true
end

class EmployeeShareText
  include DataMapper::Resource
  include Paperclip::Resource
  property :id, Serial
  belongs_to :share_text, :key => true
  belongs_to :employee, :key => true
end
 
DataMapper.auto_upgrade!
