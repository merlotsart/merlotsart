ActiveAdmin.register Order do

  #whitelist params
  permit_params :public_event_id, :private_event_id, :name, :email, :phone

  #index per page count
  config.per_page = 20

  #does not all edit or destroy actions
  actions :all, except: [:edit, :destroy, :new]

  #new actions - controller and route generators
  member_action :cancel, method: :get do
    @order       = Order.find(params[:id])
    @attendees   = @order.attendees
    # @transaction =
      if @order.payment_id == nil
        nil
      else
        Braintree::Transaction.find(@order.payment_id)
      end
  end

  member_action :email, method: :get do
    order = Order.find(params[:id])
    UserMailer.confirmation(order).deliver_now
    flash[:notice] = "Email successfully sent"
    redirect_to admin_order_path(order)
  end

  member_action :refund, method: :post do
    order = Order.find(params[:id])
    order.attendees.where.not(name: nil).each do |attendee|
      UserMailer.email(attendee, params[:subject], params[:body]).deliver_now
    end
    order.cancel_order
    flash[:notice] = "Order successfully cancelled"
    redirect_to admin_order_path(order)
  end

  member_action :participants, method: :get do
    @attendees = Order.find(params[:id]).attendees
  end

  #action display in views
  action_item :email, except: [:index] do
    link_to("Resend Confirmation Email", email_admin_order_path(id: params[:id]))
  end

  action_item :cancel, except: [:index] do
    link_to("Cancel Order", cancel_admin_order_path(id: params[:id]))
  end

  action_item :participants, except: [:index] do
    link_to("Participants", participants_admin_order_path(id: params[:id]))
  end

  #index columns
  index do
    column :name
    column :status
    column :email
    column :phone
    column "Participants" do |post|
      post.attendees.count
    end
    column :total
    column :discount_code
    column :groupon_code
    column :public_event
    column :created_at do |post|
      post.created_at.strftime("%b %e, %Y at %l:%M%P")
    end
    actions
  end

  #Show page fields
  show do
    attributes_table do
      row :public_event
      row :private_event
      row :name
      row :status
      row :email
      row :phone
      row :total
      row "Braintree payment id" do |post|
        post.payment_id
      end
      row :discount_code
      row :groupon_code
    end
  end

  #Index filters
  filter :name
  filter :email
  filter :phone
  filter :status
  filter :public_event

  csv do
    column :id
    column :name
    column :status
    column :email
    column :phone
    column :total
    column :quantity

    column(:event_attended) do |order|
      if order.public_event
        order.public_event.name
      elsif order.private_event
        order.private_event.name
      else
        "No class found"
      end
    end

    column :discount_code
    column :groupon_code
  end
end
