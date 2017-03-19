ActiveAdmin.register PublicEvent do

  #whitelist params
  permit_params :name, :available_slots, :image, :experience_id, :description, :location_id, :artist_id, :date, :start_time, :end_time, :price, :live, :byob_fee, :unlimited_wine, :unlimited_mimosas, :voucher_upgrade_fee, :groupon

  #new actions - controller and route generators
  member_action :clone, method: :get do
    @class = PublicEvent.find(params[:id])
    @resource = @class.dup
    @resource.update_attributes(experience_id: nil, location_id: nil, artist_id: nil)
    @resource.image = @class.image
    @resource.save
    render :new, layout: false
  end

  member_action :email, method: [:get, :post] do
    @class = PublicEvent.find(params[:id])
    if request.post?
      @class.attendees.where.not(name: nil).each do |attendee|
        UserMailer.email(attendee, params[:subject], params[:body]).deliver_now
      end
      flash[:notice] = "Email successfully sent"
      redirect_to email_admin_public_event_path(@class)
    else
    end
  end

  member_action :cancel, method: :get do
    @class  = PublicEvent.find(params[:id])
    @orders = @class.orders
  end

  member_action :orders, method: :get do
    @class  = PublicEvent.find(params[:id])
    @orders = @class.orders
  end

  member_action :refund, method: :post do
    @class = PublicEvent.find(params[:id])
    @class.update_attributes(status: 'cancelled', live: false)
    @class.orders.each { |order| order.cancel_order }
    @class.attendees.where.not(name: nil).each do |attendee|
      UserMailer.email(attendee, params[:subject], params[:body]).deliver_now
    end
    flash[:notice] = "Class successfully cancelled and refunded"
    redirect_to cancel_admin_public_event_path(@class)
  end

  member_action :participants, method: :get do
    @attendees = PublicEvent.find(params[:id]).attendees.order(:name)
  end

  #action display in views
  action_item :clone, except: [:index, :new, :create] do
    link_to("Make a Copy", clone_admin_public_event_path(id: params[:id]))
  end

  action_item :send_email, except: [:index, :new, :create] do
    link_to("Send email", email_admin_public_event_path(id: params[:id]))
  end

  action_item :cancel, except: [:index, :new, :create] do
    link_to("Cancel Class", cancel_admin_public_event_path(id: params[:id]))
  end

  action_item :orders, except: [:index, :new, :create] do
    link_to("Orders", orders_admin_public_event_path(id: params[:id]))
  end

  action_item :participants, except: [:index, :new, :create] do
    link_to("Participants", participants_admin_public_event_path(id: params[:id]))
  end

  action_item :view, except: [:index, :new, :create] do
    link_to('View on site', public_event_path(id: params[:id]))
  end

  #index per page count
  config.per_page = 10

  #remove batch actions button from index
  config.batch_actions = false

  #index scopes
  scope :all, default: true
  scope :upcoming

  #index columns
  index do
    selectable_column
    column "Image" do |post|
      link_to image_tag(post.image.url(:thumb)), admin_public_event_path(post)
    end
    column "Name" do |post|
      link_to post.name, admin_public_event_path(post)
    end
    column :artist
    column :date
    column "Time" do |post|
      post.start_time.strftime("%l:%M%P") + "-" + post.end_time.strftime("%l:%M%P")
    end
    column "Seats Sold" do |post|
      post.num_slots_sold.to_s + " of " + post.available_slots.to_s
    end
    column :live
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :experience
      f.input :description
      f.input :location
      f.input :artist
      f.input :image, as: :file
      f.input :date, as: :date_select
      f.input :start_time, as: :time_picker
      f.input :end_time, as: :time_picker
      f.input :available_slots
      f.input :price
      f.input :byob_fee
      f.input :unlimited_wine
      f.input :unlimited_mimosas
      f.input :voucher_upgrade_fee
      f.input :groupon
      f.input :live
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
      row :experience
      row :description
      row :status
      row :location
      row :artist
      row :date
      row "Time" do |post|
        post.start_time.strftime("%l:%M%P") + "-" + post.end_time.strftime("%l:%M%P")
      end
      row "Seats Sold" do |post|
      post.num_slots_sold.to_s + " of " + post.available_slots.to_s
    end
      row :price
      row :byob_fee
      row :unlimited_wine
      row :unlimited_mimosas
      row :voucher_upgrade_fee
      row :groupon
      row :live
    end
  end

  #Index filters
  filter :location
  filter :experience
  filter :artist
  filter :date
  filter :name
  filter :live

  csv do
    column :id
    column :name

    column :location do |public_event|
      public_event.location.name
    end

    column :seats_sold do |public_event|
      public_event.num_slots_sold.to_s + " of " + public_event.available_slots.to_s
    end

    column :artist do |public_event|
      public_event.artist.name
    end

    column :date

    column :time do |public_event|
      public_event.start_time.strftime("%l:%M%P") + "-" + public_event.end_time.strftime("%l:%M%P")
    end

    column :price
    column :byob_fee
    column :unlimited_wine
    column :unlimited_mimosas
    column :voucher_upgrade_fee
    column :groupon
    column :live

  end
end
