class Requirement < ActiveRecord::Base
     belongs_to :project, :foreign_key => 'project_id'
   has_many :test_plans
end
