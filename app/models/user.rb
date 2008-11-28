require 'digest/sha1'
class User < ActiveRecord::Base
     has_many :features
     has_many :user_project_relationship
     has_many :projects, :through => :user_project_relationship
     validates_presence_of :username, :first_name, :last_name, :email,
       :company_name, :hashed_password, :role
     validates_uniqueness_of :username, :case_sensitive => false
     validates_length_of :username, :within => 3..40
     validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
     validates_format_of :role, :with => /(Admin|Manager|Developer|Customer)/, :message => "Invalid role"
     attr_protected :id
     attr_accessor :password, :password_confirmation

     validates_presence_of :password, :password_confirmation, :on => :create 
     validates_confirmation_of :password, :on => :create
     validates_length_of :password, :within => 5..40, :on => :create
     
     def password=(pass)
       @password=pass
       self.hashed_password = Digest::SHA1.hexdigest(pass)
     end
    def self.authenticate(login, pass)
      login.downcase!
      login.strip!
       u=find(:first, :conditions=>["username = ?", login])
       return nil if u.nil?
       return u if Digest::SHA1.hexdigest(pass)==u.hashed_password
       nil
     end

end

