class CreateProjectRequests < ActiveRecord::Migration
  def change
    create_table :project_requests do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :zip
      t.string :size

      t.timestamps null: false
    end
  end
end
