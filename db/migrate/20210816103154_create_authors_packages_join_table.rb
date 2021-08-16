class CreateAuthorsPackagesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :authors, :packages do |t|
      # t.index [:author_id, :package_id]
      # t.index [:package_id, :author_id]
    end
  end
end
