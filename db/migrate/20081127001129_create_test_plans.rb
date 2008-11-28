class CreateTestPlans < ActiveRecord::Migration
  def self.up
    create_table :test_plans do |t|
      t.text :description
      t.integer :requirement_id
      t.timestamps
    end
  end

  def self.down
    drop_table :test_plans
  end
end
