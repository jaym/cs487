class CreateRequirements < ActiveRecord::Migration
  def self.up
    create_table :requirements do |t|
      t.string :name
      t.text :description
      t.text :status
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :requirements
  end
end
