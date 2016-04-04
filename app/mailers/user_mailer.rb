class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'merlotsart.com/users/sign_in'
    mail(to: @user.email, subject: "Welcome to Merlot's Art")
  end

  def admin_email(user, subject, body)
    @user = user
    @body = body
    mail(to: @user.email, subject: subject)
  end

  def email(user, subject, body)
    @user = user
    @body = body
    mail(to: @user.email, subject: subject)
  end

  def private_event(event)
    @user = event.name
    @private_event = event
    mail(to: event.email, cc: 'info@merlotsart.com', subject: 'Private Event Confirmation')
  end

  def confirmation(order)
    @order = order
    @public_event = @order.public_event
    mail(to: order.email, cc: 'info@merlotsart.com', subject: "Merlot's Art Class Confirmation")
  end

  def reminder(attendee)
    @attendee = attendee
    @public_event = @attendee.public_event
  end

  def contact(params)
    @params = params
    mail(to: 'info@merlotsart.com', subject: "User Contact Form Message")
  end

  def partner(params)
    @params = params
    mail(to: 'partnerships@merlotsart.com', subject: "Partner With Us Contact Form Message")
  end

  def licensee_application(licensee_application)
    @licensee_application = licensee_application
    mail(to: 'partnerships@merlotsart.com', subject: "New Licensee Application")
  end
end
