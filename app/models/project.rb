class Project < ActiveRecord::Base
     has_many :user_project_relationship
   has_many :users, :through => :user_project_relationship
   has_many :requirements, :dependent => :destroy
   has_many :feature_project_relationships
   has_many :features, :through => :feature_project_relationships
end
