ActiveAdmin.register Artist do

  #whitelist params
  permit_params :name, :bio, :image

  #index per page count
  config.per_page = 20

  #remove filters
  config.filters = false

  #index columns
  index do
    column :id
    column :name
    column :bio
    column "Image" do |post|
      link_to image_tag(post.image.url(:thumb)), admin_artist_path(post)
    end
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :bio
      f.input :image, as: :file
      end
    f.actions
  end

  #Show page fields
  show do
    attributes_table do
      row :name
      row :bio
      row :image do |post|
        image_tag(post.image.url(:thumb))
      end
    end
  end

end
