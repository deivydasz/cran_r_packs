class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.string    :name 
      t.string    :Version 
      t.datetime  :publication_date 
      t.string    :title 
      t.text      :description 

      t.timestamps
    end
  end
end
