ActiveAdmin.register Attendee do

  #whitelist params
  permit_params :name, :email, :phone, :public_event_id, :private_event_id

  #removes link from global menu
  menu false

  #index per page count
  config.per_page = 20

  #remove filters
  config.filters = false

  #new actions - controller and route generators
  member_action :checkin, method: :post do
    attendee = Attendee.find_by_id(params[:id])
    attendee.update_attributes(attended: true)
    redirect_to participants_admin_public_event_path(PublicEvent.find_by_id(attendee.public_event_id))
  end

  member_action :checkout, method: :post do
    attendee = Attendee.find_by_id(params[:id])
    attendee.update_attributes(attended: false)
    redirect_to participants_admin_public_event_path(PublicEvent.find_by_id(attendee.public_event_id))
  end

  action_item :delete, only: [:edit] do
    link_to("Delete Attendee", admin_attendee_path(id: params[:id]), method: 'delete', class: 'attendee-delete')
  end

  #controller methods
  controller do
    def show
      attendee = Attendee.find_by_id(params[:id])
      @order   = attendee.order
      @event   = attendee.public_event
    end

    def edit
      attendee = Attendee.find_by_id(params[:id])
      @order   = attendee.order
      @event   = attendee.public_event
    end

    def update
      attendee = Attendee.find_by_id(params[:id])
      attendee.update(attendee_params)
      redirect_to participants_admin_public_event_path(PublicEvent.find_by_id(attendee.public_event_id))
    end

    def destroy
      attendee = Attendee.find_by_id(params[:id])
      attendee.destroy
      redirect_to participants_admin_public_event_path(PublicEvent.find_by_id(attendee.public_event_id))
    end

    private
    def attendee_params
      params.require(:attendee).permit(:name, :email, :phone, :public_event_id, :private_event_id)
    end
  end

  #index columns
  index do
    column :id
    column :name
    column :email
    column :phone
    actions
  end

  #form fields
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :phone
      f.input :email
      f.input :public_event
      f.input :private_event
      end
    f.actions
    render "return_buttons"
  end

  #Show page fields
  show do
    attributes_table do
      row :name
      row :phone
      row :email
      row :public_event
      row :private_event
    end
    render "return_buttons"
  end

end
