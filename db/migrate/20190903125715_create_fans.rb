class CreateFans < ActiveRecord::Migration[5.2]
  def change
    create_table :fans do |t|
      t.belongs_to :team
      t.string :name
      t.integer :alcoholic_level

      t.timestamps
    end
  end
end
