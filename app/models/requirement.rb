class Requirement < ActiveRecord::Base
     belongs_to :project, :foreign_key => 'project_id'
     has_many :test_plans
     validates_presence_of :name, :description
     validates_format_of :status, :with => /(Accepted|Rejected|Holding|Analysis|Review|Needs Review|Reviewed)/, :message => "Invalid Status"
     validate
     protected
     def validate
       if((status == 'Accepted' || status == 'Reviewed' || status == 'Review') && test_plans.size == 0)
         errors.add("Must submit test plan!")
       end
     end
end
