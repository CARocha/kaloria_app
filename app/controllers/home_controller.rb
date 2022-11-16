class HomeController < ApplicationController
  include ApplicationHelper
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
      auth1 = cipher_cesar(auth, 5, -1)
      @user = User.find_by(email:auth1)
      if @user == nil
        redirect_to root_path
      else
        @data = [
          {name: "calories_ingested", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: @user.id).sum(:calories_ingested)},
          {name: "calories_burned", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: @user.id).sum(:calories_burned)}
        ]
      end

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
      token = cipher_cesar(@user.email, 5 )
      SharedProgressMailer.with(email: email, user: @user, token: token).shared_email.deliver_now
    end
  end
end
