class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.decimal :rate
      t.string :comment
      t.string :title
      t.string :url
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :pizza, null: false, foreign_key: true

      t.timestamps
    end
  end
end
