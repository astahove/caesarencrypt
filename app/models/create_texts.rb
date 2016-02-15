class CreateTexts < ActiveRecord::Migration
  #метод, создающий в базе данных таблицк texts
  def self.up
    create_table :texts do |t|
      t.text :inputtext
      t.integer :rotate
      t.text :crypttext
    end
  end
  #метод, удаляющий эту таблицу
  def self.down
    drop_table :texts
  end
end