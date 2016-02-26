class CreateLicenseeApplications < ActiveRecord::Migration
  def change
    create_table :licensee_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :interested_locations
      t.text :comments

      t.timestamps null: false
    end
  end
end
