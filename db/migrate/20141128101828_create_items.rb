class CreateItems < ActiveRecord::Migration
  
  def change
    create_table :items do |t|
      t.integer :list_id
      t.string :content
      t.boolean :done, :default => false
      t.timestamps
    end
  end
  
end
