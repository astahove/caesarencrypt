class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :inputtext
      t.integer :rotate
      t.text :crypttext

      t.timestamps null: false
    end
  end
end
