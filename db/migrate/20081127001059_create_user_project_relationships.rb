class CreateUserProjectRelationships < ActiveRecord::Migration
  def self.up
    create_table :user_project_relationships do |t|
       t.integer :user_id
       t.integer :project_id


      t.timestamps
    end
  end

  def self.down
    drop_table :user_project_relationships
  end
end
