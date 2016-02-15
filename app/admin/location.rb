ActiveAdmin.register Location do

  #whitelist params
  permit_params :name, :address, :city, :state, :zip, :phone, :image

  #index per page count
  config.per_page = 20

  #remove filters
  config.filters = false

  #index columns
  index do
    column :id
    column :name
    column :address
    column :city
    column :state
    column :zip
    column :phone
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :image, as: :file
      f.input :address
      f.input :city
      f.input :state
      f.input :zip
      f.input :phone
      end
    f.actions
  end

  #Show page fields
  show do
    attributes_table do
      row :name
      row :image do |post|
        image_tag(post.image.url(:thumb))
      end
      row :address
      row :city
      row :state
      row :zip
      row :phone
    end
  end

end
