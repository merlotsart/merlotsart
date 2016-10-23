ActiveAdmin.register ProjectRequest do

  #whitelist params
  permit_params :name, :email, :phone, :size

  #index per page count
  config.per_page = 20

  #remove filters
  config.filters = false

  #index columns
  index do
    column :id
    column :name
    column :email
    column :phone
    column :size
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :size, as: :select, collection: ProjectRequest::SIZE_OPTIONS
    end
    f.actions
  end

  #Show page fields
  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :size
    end
  end

end
