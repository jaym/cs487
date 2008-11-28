class CreateFeatureProjectRealationships < ActiveRecord::Migration
  def self.up
    create_table :feature_project_realationships do |t|
       t.column :project_id, :integer, :default => "",:null => false
       t.column :feature_id, :integer, :default => "", :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :feature_project_realationships
  end
end
