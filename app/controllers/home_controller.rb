class HomeController < ApplicationController
  def index
  end
  def dashboard
    auth = params[:auth_code]
    if user_signed_in?
      @user = current_user
      @data = [
        {name: "calories_ingested", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: current_user.id).sum(:calories_ingested)},
        {name: "calories_burned", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: current_user.id).sum(:calories_burned)}
      ]
    elsif !auth.blank?
      @user = User.find_by(id:auth)
      @data = [
        {name: "calories_ingested", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: @user.id).sum(:calories_ingested)},
        {name: "calories_burned", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: @user.id).sum(:calories_burned)}
      ]
    else
      redirect_to user_session_path
    end
    
    
  end
  def documentation
  end
  def shared_progress
    email = params[:email]
    @user = current_user
    if !email.blank?
      flash[:notice] =  "Email was successfully sent."
      SharedProgressMailer.with(email: email, user: @user).shared_email.deliver_now
    end
    
  end
end
