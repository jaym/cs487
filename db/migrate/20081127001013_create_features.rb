class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name
      t.text :description
      #t.text :status
      #t.text :stage
      t.string :risk
      t.string :rank
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
