class CreateMaintainersPackagesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :maintainers, :packages do |t|
      # t.index [:maintainer_id, :package_id]
      # t.index [:package_id, :maintainer_id]
    end
  end
end
