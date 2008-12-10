class TestPlan < ActiveRecord::Base
  belongs_to :requirement
  validates_presence_of :description


end
