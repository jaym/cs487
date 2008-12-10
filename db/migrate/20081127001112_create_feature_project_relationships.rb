class CreateFeatureProjectRelationships < ActiveRecord::Migration
  def self.up
    create_table :feature_project_relationships do |t|
       t.column :feature_id, :integer
       t.column :project_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :feature_project_relationships
  end
end
