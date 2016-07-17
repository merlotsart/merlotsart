ActiveAdmin.register Promo do

  #whitelist params
  permit_params :code, :discount_type, :discount_percentage, :discount_amount, :number_of_uses, :expiration_date

  #index per page count
  config.per_page = 20

  #remove filters
  config.filters = true
  filter :code
  filter :discount_type, as: :select, collection: [['Percentage', 0], ['Amount', 1]]
  filter :discount_percentage
  filter :discount_amount
  filter :number_of_uses
  filter :number_of_times_used
  filter :expiration_date
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      super.where(email: nil)
    end
  end

  #index columns
  index do
    column :code
    column :discount_type do |promo|
      promo.discount_type.titleize
    end
    column :discount_percentage do |promo|
      promo.discount_percentage ? "#{promo.discount_percentage}%" : ''
    end
    column :discount_amount do |promo|
      promo.discount_amount ? number_to_currency(promo.discount_amount) : ''
    end
    column :number_of_uses
    column :number_of_times_used
    column :expiration_date
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :code
      f.input :discount_type, as: :select, collection: {'Percentage' => :percentage, 'Amount' => :amount}, include_blank: false
      f.input :discount_percentage
      f.input :discount_amount
      f.input :number_of_uses
      f.input :expiration_date
      end
    f.actions
  end

  #Show page fields
  show do
    attributes_table do
      row :code
      row :discount_type do |t|
        t.discount_type.titleize
      end
      row :discount_percentage do |promo|
        promo.discount_percentage ? "#{promo.discount_percentage}%" : ''
      end
      row :discount_amount do |promo|
        promo.discount_amount ? number_to_currency(promo.discount_amount) : ''
      end
      row :number_of_uses
      row :number_of_times_used
      row :expiration_date
    end
  end
end
