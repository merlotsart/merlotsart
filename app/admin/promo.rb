ActiveAdmin.register Promo do

  #whitelist params
  permit_params :code, :discount_percentage, :number_of_uses, :expiration_date

  #index per page count
  config.per_page = 20

  #remove filters
  config.filters = true

  controller do
    def scoped_collection
      super.where(email: nil)
    end
  end

  #index columns
  index do
    column :code
    column :discount_percentage
    column :number_of_uses
    column :number_of_times_used
    column :expiration_date
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :code
      f.input :discount_percentage
      f.input :number_of_uses
      f.input :expiration_date
      end
    f.actions
  end

  #Show page fields
  show do
    attributes_table do
      row :code
      row :discount_percentage
      row :number_of_uses
      row :number_of_times_used
      row :expiration_date
    end
  end
end
