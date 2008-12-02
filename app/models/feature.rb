class Feature < ActiveRecord::Base
     has_many :feature_project_relationships
     has_many :projects, :through => :feature_project_relationships
     belongs_to :user, :foreign_key => 'user_id'
     validates_presence_of :name, :description
end
