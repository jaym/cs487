class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
       t.column :name,            :string, :limit => 50, :default => "", :null => false
       t.column :description,     :text,   :default => "", :null => false 
       t.column :open_date,       :datetime, :default => Time.now, :null => false 
       t.column :close_date,      :datetime, :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
