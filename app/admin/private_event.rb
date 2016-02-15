ActiveAdmin.register PrivateEvent do

  #whitelist params
  permit_params :name, :status, :available_slots, :experience_id, :description, :location_id, :artist_id, :date, :start_time, :end_time, :price, :how_hear, :email, :phone, :special_request

  #index per page count
  config.per_page = 10

  #index columns
  index do
    selectable_column
    column :status
    column :name
    column :email
    column :phone
    column :event_type
    column :artist
    column :date
    column "Time" do |post|
      post.start_time.strftime("%l:%M%P") + "-" + post.end_time.strftime("%l:%M%P")
    end
    actions
  end

  #form fields
  form do |f|
    f.inputs "Details" do
      f.input :status, :label => 'Status', :as => :select, :collection => ['Pending', 'Confirmed'], include_blank: false
      f.input :name
      f.input :email
      f.input :phone
      f.input :description
      f.input :event_type
      f.input :location
      f.input :artist
      f.input :date, as: :datepicker
      f.input :start_time, as: :time_picker
      f.input :end_time, as: :time_picker
      f.input :available_slots
      f.input :price
      f.input :how_hear
      f.input :special_request
    end
    f.actions
  end

  #Show page fields
  show do
    attributes_table do
      row :status
      row :name
      row :email
      row :phone
      row :event_type
      row :description
      row :location
      row :artist
      row :date
      row "Time" do |post|
        post.start_time.strftime("%l:%M%P") + "-" + post.end_time.strftime("%l:%M%P")
      end
      row :available_slots
      row :purchased_slots
      row :price
      row "How heard about Merlot's" do |post|
        post.how_hear
      end
      row :special_request
    end
  end

  #Index filters
  filter :status
  filter :date
  filter :name
  filter :email
  filter :event_type
end
